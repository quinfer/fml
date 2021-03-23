#' Expected Maximum Sharpe Ratio
#'
#' Calculate the theoretical Maximum Sharpe Ratio according
#'  to the False Discovery theorem first proposed
#'  by Bailey et al. 2014. Its returns values of
#'  the expected maximum Sharpe ratio controlling for the
#'  selection bias under multiple testing (SBuMT).
#' @param nTrails vector a numeric vector containing the number of trails
#' @param meanSR mean of the Sharpe ratio of the null false strategy
#' @param stdSR standard deviation of the Sharpe ratio of the null false strategy
#'
#' @return vector
#' @export
#' @references Bailey, D., J. Borwein, M. López de Prado, and J. Zhu 2014: “Pseudo- mathematics and financial charlatanism: The effects of backtest overfitting on out-of-sample performance.” Notices of the American Mathematical Society, Vol. 61, No. 5, pp. 458–471. Available at http://ssrn.com/abstract=2308659
#' @examples
#' getExpectedMaxSR(nTrails=1:100,meanSR=0,stdSR=1)
getExpectedMaxSR<-function(nTrails,meanSR,stdSR){
  emc=0.577215664901532860606512090082402431042159336
  sr0=(1-emc)*qnorm(p=1-1./nTrails)+emc*qnorm(1-(nTrails*exp(1))^(-1))
  sr0=meanSR+stdSR*sr0
  return(sr0)
}
