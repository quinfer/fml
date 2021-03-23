#' Expected Maximum Sharpe Ratio
#'
#' Calculcate the theoretical Maximum Sharpe Ratio according to the False Discovery theorem first proposed by Bailey et al. 2014.
#' @param nTrails
#' @param meanSR
#' @param stdSR
#'
#' @return
#' @export
#' @references Bailey, D., J. Borwein, M. López de Prado, and J. Zhu 2014: “Pseudo- mathematics and financial charlatanism: The effects of backtest overfitting on out-of-sample performance.” Notices of the American Mathematical Society, Vol. 61, No. 5, pp. 458–471. Available at http://ssrn.com/abstract=2308659
#' @examples
getExpectedMaxSR<-function(nTrails,meanSR,stdSR){
  # Expected Max SR controlling for SBuMT
  emc=0.577215664901532860606512090082402431042159336
  sr0=(1-emc)*qnorm(p=1-1./nTrails)+emc*qnorm(1-(nTrails*exp(1))^(-1))
  sr0=meanSR+stdSR*sr0
  return(sr0)
}
