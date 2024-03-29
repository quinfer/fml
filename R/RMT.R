#' @title  Denoising and detoning of Covariance matrix using Random Matrix Theory

#'
#' @details
#' This method takes in data as a matrix or an xts object. It then
#' fits a marchenko pastur density to eigenvalues of the correlation matrix. All
#' eigenvalues above the cutoff are retained and ones below the cutoff are
#' replaced such that the trace of the correlation matrix is 1 or non-significant
#' eigenvalues are deleted and diagonal of correlation matrix is changed to 1.
#' Finally, correlation matrix is converted to covariance matrix.
#'
#' @importFrom Matrix nearPD
#' @importFrom RMTstat dmp qmp
#' @importFrom foreach foreach "%dopar%" registerDoSEQ
#' @importFrom parallel detectCores stopCluster makeCluster clusterEvalQ clusterExport
#' @importFrom doParallel registerDoParallel
#' @importFrom stats cov cov2cor optim start
#' @importFrom utils head
#' @importFrom xts is.xts
#' @importFrom zoo coredata
#'
#' @param  R xts or matrix of asset returns with columns as return series
#' @param  Q ratio of rows/size. Can be supplied externally or fit using data
#' @param  cutoff takes two values max/each. If cutoff is max, Q is fitted and
#'          cutoff for eigenvalues is calculated. If cutoff is each, Q is set to
#'          row/size. Individual cutoff for each eigenvalue is calculated and used
#'          for filteration.
#' @param eigenTreat takes 2 values, average/delete. If average then the noisy
#'        eigenvalues are averaged and each value is replaced by average. If delete
#'        then noisy eigenvalues are ignored and the diagonal entries of the
#'        correlation matrix are replaced with 1 to make the matrix psd.
#' @param numEig number of eigenvalues that are known for variance calculation.
#'        Default is set to 1. If numEig = 0 then variance is assumed to be 1.
#' @param parallel boolean to use all cores of a machine.
#' @param detone boolean to detoning the correlation matrix of the market component,
#' where the market component is assumed to be the eigenvector with the highest eigenvalue
#' @param market_component the index of the market component in the eigenvectors and eigenvalues. Defaults to 1 as eigen function automatically ranks in descending order.
#' @examples
#' \dontrun{
#'  data("largereturn")
#'  model <- estRMT(largesymdata, numEig = 0)
#' }
#'
#' @author Barry Quinn
#'
#' @export
#'
estRMT <- function(R, Q =NA, cutoff = c("max", "each"),
                   eigenTreat = c("average", "delete") , numEig=1,
                   parallel = TRUE, detone= FALSE,market_component=1) {
  .data <- if(is.xts(R)) coredata(R) else as.matrix(R)
  T <- nrow(.data); M <- ncol(.data); Nams<-colnames(.data);
  if (T < M) stop("Does not work when T < M")

  if(!is.na(Q)) if(Q < 1) stop("Does not work for Q<1")

  cutoff <- cutoff[1]; if(!cutoff %in% c("max", "each")) stop("Invalid cutoff")
  if(cutoff == "each") Q <- T/M

  eigenTreat <- eigenTreat[1];
  if(!eigenTreat %in% c("average", "delete")) stop("Invalid eigenTreat option")

  if (numEig < 0) stop("Number of eigenvalues must be non-negative")

  #eigenvalues can be negative. To avoid this e need a positive-definite matrix
  S <- cov(.data); S <- as.matrix(nearPD(S)$mat)
  D <- diag(diag(S)); C <- cov2cor(S);

  # Marchenko Pastur density is defined for eigenvalues of correlation matrix
  eigen.C <- eigen(C,symmetric=T)
  lambdas <- eigen.C$values; sigma.sq <- mean(lambdas)

  #minimize log-likelihood.
  loglik.marpas <- function(theta, sigma.sq) {

    Q <- theta
    val <- sapply(lambdas,
                  function(x) dmp(x,svr = Q, var=sigma.sq))

    val <- val[val > 0]
    ifelse(is.infinite(-sum(log(val))), .Machine$double.xmax, -sum(log(val)))
  }

  sigma.sq <- 1 - sum(head(lambdas,numEig))/M

  if( is.na(Q) && cutoff != "each") {
    lb <- 1; ub <- max(T/M,5)
    if(parallel) {
      cl <- makeCluster(detectCores())
      registerDoParallel(cl)
      clusterEvalQ(cl, library(RMTstat))
    }

    '%exectype%' <- if (parallel) get('%dopar%') else get('%do%')

    starts <- seq(lb, ub, length.out = 50)
    fit.marpas <- foreach(start = starts, .combine = rbind) %exectype%
      optim(par = start, fn = loglik.marpas, method = "L-BFGS-B",
            lower = lb, upper = ub, sigma.sq = sigma.sq)

    if(parallel) stopCluster(cl)

    idx <- grep("CONVERGENCE",unlist(fit.marpas[,"message"]))
    vals <- fit.marpas[idx,c("par","value")]
    Q <- unlist(vals[which.min(vals[,"value"]),"par"])
  }

  lambda.max <- qmp(1, svr=Q, var = sigma.sq)
  # now that we have a fit. lets denoise eigenvalues below the cutoff

  idx <- if(cutoff == "max")
    which(lambdas > lambda.max)
  else if(cutoff == "each")
  {
    cutoff.each <- sapply(2:length(lambdas), function(i) {
      eigr <- lambdas[i:M]
      mean(eigr)*(1 + (M - i + 1)/T + 2*sqrt((M - i + 1)/T))
    })

    c(1, 1 + which(lambdas[-1] > cutoff.each))
  }

  if (length(idx) == 0) return(S)

  val <- eigen.C$values[idx]; vec <- eigen.C$vectors[,idx,drop=FALSE]
  sum <- 0; for (i in 1:ncol(vec)) sum <- sum + val[i]*vec[,i] %*% t(vec[,i])

  # trace of correlation matrix is 1. Use this to determine all the remaining
  # eigenvalues

  lambdas.cleaned <- c()
  clean.C <- if (eigenTreat == "average") {
    lambdas.cleaned <- c(val, rep(1,M))
    sum + sum(eigen.C$values[-idx])/M * diag(rep(1,M))
  } else if (eigenTreat == "delete") {
    lambdas.cleaned <- c(val, rep(0,M))
    diag(sum) <- 1
    sum
  }
  if (detone) {
    # Define them market component as first eigenvalue with the highest eigenvector
    eigen.CC<-eigen(clean.C,symmetric=T)
    eigenvalues_mark = eigen.CC$values[1:market_component]
    eigenvectors_mark = as.matrix(eigen.CC$vectors[,1:market_component])
    C_mark = eigenvectors_mark%*%eigenvalues_mark%*%t(eigenvectors_mark)
    clean.C<-C-C_mark
    # convert correlation to covariance matrix and return
    clean.S <- D^0.5 %*% clean.C %*% D^0.5
    colnames(clean.S)<-Nams
    rownames(clean.S)<-Nams
    fit <- list(cov = clean.S, Q = Q, var = sigma.sq, eigVals = lambdas,
                eigVals.cleaned = lambdas.cleaned, lambdascutoff = lambda.max)
    class(fit) <- "RMT"
    fit
  }

  # convert correlation to covariance matrix and return
  clean.S <- D^0.5 %*% clean.C %*% D^0.5
  colnames(clean.S)<-Nams
  rownames(clean.S)<-Nams
  fit <- list(cov = clean.S, Q = Q, var = sigma.sq, eigVals = lambdas,
              eigVals.cleaned = lambdas.cleaned, lambdascutoff = lambda.max)

  class(fit) <- "RMT"
  fit
}
