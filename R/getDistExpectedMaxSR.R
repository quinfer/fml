#' Maximum Sharpe Ratio Monte Carlo Simulator
#'
#' Simulates the distribution of the expected Maximum Sharpe ratio for a set number of trails
#' @param nSims number of simulations per trail
#' @param nTrails a numeric vector of trails starting at 2
#' @param meanSR mean value of Sharpe ratio under the null of a false positive strategy
#' @param stdSR standard deviation of Sharpe ratio under the null of a false positive strategy
#' @importFrom tibble tibble
#' @importFrom dplyr bind_rows
#' @return tibble
#' @export
#'
#' @examples
getDistExpectedMaxSR<-function(nSims,nTrails,meanSR,stdSR){
  out=tibble("Max{SR}"=NA,"nTrails"=NA)
  for (nTrails_ in nTrails) {
    set.seed(nTrails_)
    sr<-array(rnorm(nSims*nTrails_),dim = c(nSims,nTrails_))
    sr<-apply(sr,1,scale) # demean and scale
    sr= meanSR+sr*stdSR
    out<-bind_rows(out,
      tibble("Max{SR}"=apply(sr,2,max),"nTrails"=nTrails_))
  }
  return(out[-1,])
}
