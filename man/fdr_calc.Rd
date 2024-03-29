% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fdr_calc.R
\name{fdr_calc}
\alias{fdr_calc}
\title{False discovery rate}
\usage{
fdr_calc(ground_truth, alpha = 0.05, beta, trails)
}
\arguments{
\item{ground_truth}{double probability of a positive results}

\item{alpha}{double level of significance}

\item{beta}{double Type || error}

\item{trails}{integer No of trails}
}
\value{
tibble
}
\description{
The function express the false discovery rate associated with selection bias in multiple testing.
This produces a tibble of the recall, precision and false discovery rate
when give the true probability of a positive results, the significance level,
,the false negative rate (Type II error) and the number of trails.
}
\examples{
fdr_calc(0.01,beta=0.4,trails=10000)
}
