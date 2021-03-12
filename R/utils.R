#' @export
#' @title  Discretisation of a continuous variable
#' @param nObs number of observations
#' @param corr the correlation for the bivariate case
numBins<-function(nObs,corr=NULL){
  #Optimal
  if (is.null(corr)) {
    z=(8+324*nObs+12*(36*nObs+729*nObs^2)^0.5)^(1/3)
    b=round(z/6+2/(3*z)+1/3)
  }
  else {
    #bivariate case
    b=round(2^(-0.5)*(1+(1+24*nObs/(1-corr^2))^0.5)^0.5)
  }
  return(b)
}
