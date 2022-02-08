#' @name mp_pdf
#' @title Marcenko Pastur pdf function
#' @description create m-p distribution for random matrix
#' @importFrom matlab linspace
#' @param var variance
#' @param t time 
#' @param m number of stocks
#' @param pts number of data points to sample
#' @keywords Marcenko-Pastur
#' @export
#'
mp_pdf<-function(var=1,t,m,pts) {
  q=t/m
  eMin<-var*(1-(1./q)^.5)^2 
  eMax<-var*(1+(1./q)^.5)^2 
  eVal<-linspace(eMin,eMax,pts)
  pdf<-q/(2*pi*var*eVal)*((eMax-eVal)*(eVal-eMin))^.5
  pdf<-array(pdf) 
  names(pdf)<-eVal # creates a named array
  return(pdf)  
}
