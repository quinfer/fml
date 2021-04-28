#' Random Matrix with Signal
#' Function to create a random matrix with a number of ground truth facts or signals.
#' @param nCols number of columns or stocks
#' @param nFacts  number of signals to add to the random matrix
#' @importFrom stats rnorm
#' @return matrix
#' @export
#' @references López de Prado, Marcos. 2020. “Machine Learning for Asset Managers.” In Elements in Quantitative Finance. Cambridge University Press.
#' @examples
#' nCols=1000
#' nFacts=100
#' alpha<-q<-0.95
#' rtns=array(rnorm(nCols*q*nCols),dim = c(nCols*q,nCols))
#' cov1=cov(rtns)
#' cov1=alpha*cov1+(1-alpha)*getRndCoV(nCols = nCols,nFacts = nFacts)
#' corr0=cov2cor(cov1)
#' eigs=eigen(corr0)

getRndCoV <- function(nCols,nFacts){
  w=array(rnorm(nCols*nFacts),dim = c(nCols,nFacts))
  coV=w %*% t(w)
  s=diag(runif(nCols))
  coV=coV+s
  return(coV)
}

