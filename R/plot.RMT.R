#' @title Eigenvalue plot
#'
#' @details
#' Plots eigenvalues of the correlation matrix and overlays the Marchenko-Pastur
#' density on top of it. There is a shap cutoff for the density. We are concerned
#' with eigenvalues beyond this cutoff. Paramters used for plotting are added
#' to the plot
#'
#' @importFrom ggplot2 ggplot geom_histogram aes_string stat_function aes xlab ylim theme annotate scale_colour_manual element_text labs
#' @param x model of the type RMT obtained by fitting an RMT model to the data
#' @param y unused
#' @param ... additional arguments unused
#' @author Barry Quinn
#' @examples
#' \dontrun{
#'  data("largereturn")
#'  model <- estRMT(largesymdata)
#'  plot(model)
#' }
#'
#' @method plot RMT
#' @export
#'
plot.RMT <- function(x, y, ...){

  lambdas <- x$eigVals; Q <- x$Q; sigma.sq <- x$var
  lambda.max <- x$lambdascutoff

  p <- ggplot(data=data.frame(lambdas)) +
    geom_histogram( aes_string(x = 'lambdas', y='..density..'),
                    breaks=seq(min(lambdas)-1,1+max(lambdas),0.5),
                    colour="black", fill="white") +
    stat_function(fun = dmp, args=list(svr = Q, var=sigma.sq),
                  aes(colour = 'MP density')) + xlab("Eigenvalues") +
    labs(title="Actual vs Fitted Marchenko-Pastur") + ylim(0,1.5) +
    theme(plot.title = element_text(size = 20, face = "bold", vjust = 1),
          axis.title=element_text(size=14,face="bold")) +
    annotate('text', x = 10, y = 0.9,
             label = paste("sigma^{2} == ", round(sigma.sq,3)), parse=TRUE) +
    annotate('text', x = 10, y = 1,
             label = paste("Q == ", round(Q,3)), parse=TRUE) +
    annotate('text', x = 10, y = 0.78,
             label = paste("lambda[max] ==", round(lambda.max,3)), parse=TRUE) +
    scale_colour_manual("", values = c("red"))

  options(warn = -1)
  print(p)
  options(warn = 0)
  p
}
