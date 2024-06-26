#' Maximum Sharpe Ratio Monte Carlo Simulator
#'
#' Simulates the distribution of the expected Maximum Sharpe ratio for a set number of trails
#' @param nSims number of simulations per trail
#' @param nTrials a numeric vector of trails starting at 2
#' @param meanSR mean value of Sharpe ratio under the null of a false positive strategy
#' @param stdSR standard deviation of Sharpe ratio under the null of a false positive strategy
#' @importFrom tibble tibble
#' @importFrom dplyr bind_rows
#' @importFrom stats rnorm
#' @importFrom scales alpha
#' @return tibble
#' @export
#' @references Bailey, D., J. Borwein, M. López de Prado, and J. Zhu 2014: “Pseudo- mathematics and financial charlatanism: The effects of backtest overfitting on out-of-sample performance.” Notices of the American Mathematical Society, Vol. 61, No. 5, pp. 458–471. Available at http://ssrn.com/abstract=2308659
#' @examples
#' sr1<-getDistExpectedMaxSR(nSims=100,nTrials=2:100)
#' plot(y=sr1$`Max{SR}`,x=sr1$nTrials, col = scales::alpha('red', 0.4), pch=16)
#' lines(lowess(x=sr1$nTrials,sr1$`Max{SR}`),col="blue")
getDistExpectedMaxSR<-function(nSims,nTrials,meanSR=0,stdSR=1){
  out=tibble("Max{SR}"=NA,"nTrials"=NA)
  for (nTrials_ in nTrials) {
    set.seed(nTrials_)
    sr<-array(rnorm(nSims*nTrials_),dim = c(nSims,nTrials_))
    sr<-apply(sr,1,scale) # demean and scale
    sr= meanSR+sr*stdSR
    out<-bind_rows(out,
      tibble("Max{SR}"=apply(sr,2,max),"nTrials"=nTrials_))
  }
  return(out[-1,])
}
