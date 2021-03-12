## FTSE30_load.R

library(tidyquant)
library(tidyverse)
library(usethis)
load("data-raw/Top30prices.RData")

use_data(Top30prices, overwrite = TRUE)


ftse30_returns_mthly<-Top30prices %>%
  group_by(symbol) %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period="monthly",
               col_rename = "Rtn")

use_data(ftse30_returns_mthly, overwrite = TRUE)


