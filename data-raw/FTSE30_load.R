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


ftse350<-tsfe::ftse350
use_data(ftse350, overwrite = TRUE)

ftse350 %>%
  select(-Name) %>%
  spread(variable,value) %>%
  group_by(ticker) %>%
  summarise(mean_mv=mean(`Market Value`)) %>%
  mutate(rank = min_rank(desc(mean_mv))) %>%
  filter(rank<=25) %>%
  select(ticker) %>%
  unlist(use.names = F) -> tickers

ftse350 %>%
  select(-Name) %>%
  spread(variable,value) %>%
  filter(ticker %in% tickers) %>%
  group_by(ticker) %>%
  tq_transmute(select = Price,
               mutate_fun = monthlyReturn) %>%
  pivot_wider(names_from=ticker,
              values_from=monthly.returns)->ftse25_rtns_mthly

use_data(ftse25_rtns_mthly, overwrite = TRUE)
