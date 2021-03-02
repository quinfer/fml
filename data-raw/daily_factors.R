## code to prepare `DATASET` dataset goes here
path="~/Dropbox/Teaching/TSFE/tsfe/data-raw/dat.RData"
load(path)
daily_factors<-uk_factor_d
usethis::use_data(daily_factors, overwrite = TRUE)
# Daily paths
"wget https://reshare.ukdataservice.ac.uk/852704/1/dailyfactors.zip"