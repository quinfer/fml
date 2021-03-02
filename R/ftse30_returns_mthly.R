#' Data of monthly returns of Top 30 stocks in the FTSE 100 as of 24/02/2021
#'
#' The daily adjusted closing prices were sourced form yahoo finance using tidyquant::tq_get for the period 2020-01-01 to 20/02/2021
#'
#' @format A tibble with 420 rows and 3 variables:
#' \describe{
#'   \item{symbol}{chr ticker symbol as designated by yahoo finance}
#'   \item{date}{date recorded as YYYY-MM-DD } 
#'   \item{Rtn}{Monthly log returns}
#' }
#' @source \url{https://uk.finance.yahoo.com/}
"ftse30_returns_mthly"