#' Expected Maximum Sharpe Ratio
#'
#' Calculate the theoretical Maximum Sharpe Ratio according
#' to the False Discovery theorem first proposed
#' by Bailey et al. 2014. Its returns values of
#' the expected maximum Sharpe ratio controlling for the
#' selection bias under multiple testing (SBuMT).
#' @param nTrials double the number of trials (note that 1 trial will produce a -Inf result)
#' @param meanSR mean of the Sharpe ratio of the null false strategy
#' @param stdSR standard deviation of the Sharpe ratio of the null false strategy
#' @importFrom stats qnorm
#' @return numeric
#' @export
#' @references Bailey, D., J. Borwein, M. López de Prado, and J. Zhu 2014: "Pseudo- mathematics and financial charlatanism: The effects of backtest overfitting on out-of-sample performance." Notices of the American Mathematical Society, Vol. 61, No. 5, pp. 458–471. Available at http://ssrn.com/abstract=2308659
#' @examples
#' getExpectedMaxSR(nTrials=100)

getExpectedMaxSR <- function(nTrials, meanSR = 0, stdSR = 1) {
  emc <- 0.577215664901532860606512090082402431042159336
  sr0 <- (1 - emc) * qnorm(p = 1 - 1./nTrials) + emc * qnorm(1 - (nTrials * exp(1))^(-1))
  sr0 <- meanSR + stdSR * sr0
  return(sr0)
}
