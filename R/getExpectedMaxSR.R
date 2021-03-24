#' Expected Maximum Sharpe Ratio
#'
#' Calculate the theoretical Maximum Sharpe Ratio according
#'  to the False Discovery theorem first proposed
#'  by Bailey et al. 2014. Its returns values of
#'  the expected maximum Sharpe ratio controlling for the
#'  selection bias under multiple testing (SBuMT).
#' @param nTrails double the number of trails (note that 1 trail will produce a -Inf results)
#' @param meanSR mean of the Sharpe ratio of the null false strategy
#' @param stdSR standard deviation of the Sharpe ratio of the null false strategy
#' @importFrom stats qnorm
#' @return numeric
#' @export
#' @references Bailey, D., J. Borwein, M. López de Prado, and J. Zhu 2014: “Pseudo- mathematics and financial charlatanism: The effects of backtest overfitting on out-of-sample performance.” Notices of the American Mathematical Society, Vol. 61, No. 5, pp. 458–471. Available at http://ssrn.com/abstract=2308659
#' @examples
#' getExpectedMaxSR(nTrails=100)
getExpectedMaxSR<-function(nTrails,meanSR=0,stdSR=1){
  emc=0.577215664901532860606512090082402431042159336
  sr0=(1-emc)*qnorm(p=1-1./nTrails)+emc*qnorm(1-(nTrails*exp(1))^(-1))
  sr0=meanSR+stdSR*sr0
  return(sr0)
}
