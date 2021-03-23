fdr_calc <- function(ground_truth,alpha=0.05,beta,trails) {
  theta=ground_truth/(1-ground_truth)
  recall=1-beta
  b1=recall*theta
  precision=b1/(b1+alpha)
  tibble(Recall=recall,Precision=precision,FDR=1-precision)
}
