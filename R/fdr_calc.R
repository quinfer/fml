#' False discovery rate
#'
#' The function express the false discovery rate associated with selection bias in multiple testing.
#' This produces a tibble of the recall, precision and false discovery rate
#' when give the true probability of a positive results, the significance level,
#' ,the false negative rate (Type II error) and the number of trails.
#' @param ground_truth double probability of a positive results
#' @param alpha double level of significance
#' @param beta double Type || error
#' @param trails integer No of trails
#'
#' @return tibble
#' @export
#'
#' @examples
#' fdr(0.01,beta=0.4,trails=10000)
fdr_calc <- function(ground_truth,alpha=0.05,beta,trails) {
  theta=ground_truth/(1-ground_truth)
  recall=1-beta
  b1=recall*theta
  precision=b1/(b1+alpha)
  tibble(Recall=recall,Precision=precision,FDR=1-precision)
}
