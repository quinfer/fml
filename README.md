
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Financial machine learning

<img src="inst/figures/imgfile.png" width="10%" style="inline">

The goal of fml is to learning about the emerging field of financial
machine learning and its applications in computer age econometrics.  This package contains templates for reports, and functions and workshops
using in [*Algorithmic trading and
investment*](https://canvas.qub.ac.uk/courses/11744)) taught by [Barry
Quinn](https://quinference.com/) in [Queen’s Management School](https://pure.qub.ac.uk/en/persons/barry-quinn).

## Installation

Install/or reinstall the package from [GitHub](https://github.com/)
using the following.


``` r
remove.packages('fml')
.rs.restartR()
remotes::install_github("quinfer/fml")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(fml)
library(tidyverse)
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
#> ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
#> ✓ tibble  3.1.6     ✓ dplyr   1.0.7
#> ✓ tidyr   1.1.4     ✓ stringr 1.4.0
#> ✓ readr   2.1.1     ✓ forcats 0.5.1
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
## basic example code
fml::daily_factors %>% summary()
#>       date                  rm                   rf           
#>  Min.   :1988-10-03   Min.   :-0.0834130   Min.   :0.0000000  
#>  1st Qu.:1996-01-23   1st Qu.:-0.0046057   1st Qu.:0.0000210  
#>  Median :2003-05-19   Median : 0.0006790   Median :0.0001825  
#>  Mean   :2003-05-15   Mean   : 0.0003942   Mean   :0.0001765  
#>  3rd Qu.:2010-09-06   3rd Qu.: 0.0055839   3rd Qu.:0.0002231  
#>  Max.   :2017-12-29   Max.   : 0.0921039   Max.   :0.0005430  
#>       rmrf                 smb                  hml            
#>  Min.   :-0.0835837   Min.   :-6.301e-02   Min.   :-4.187e-02  
#>  1st Qu.:-0.0047718   1st Qu.:-3.755e-03   1st Qu.:-2.963e-03  
#>  Median : 0.0005000   Median : 1.062e-04   Median :-7.734e-05  
#>  Mean   : 0.0002178   Mean   :-2.793e-05   Mean   : 6.069e-05  
#>  3rd Qu.: 0.0053843   3rd Qu.: 3.883e-03   3rd Qu.: 2.888e-03  
#>  Max.   : 0.0920217   Max.   : 3.561e-02   Max.   : 5.784e-02  
#>       umd            
#>  Min.   :-0.0813362  
#>  1st Qu.:-0.0034154  
#>  Median :-0.0001573  
#>  Mean   :-0.0003336  
#>  3rd Qu.: 0.0030267  
#>  Max.   : 0.0599399
```

## Function test

``` r
?fml::estRMT()
```

## Tutorials

**The tutorials can be run on a local machine only**. You can start the
tutorials in one of two ways. First, in RStudio 1.3 or later, you will
find the ATI tutorials listed in the “Tutorial” tab in the top-right
pane (by default). Find a tutorial and click “Run Tutorial” to get
started. Second, you can run any tutorial from the R console by typing
the following line:

``` r
learnr::run_tutorial("Workshop2","fml")
```

This should bring up a tutorial in your default web browser. You can see
the full list of tutorials by running:

``` r
learnr::run_tutorial(package = "fml")
```

## Critical Essay

This package also includes a RMarkdown template for use in the critical
essay assessment. Go to File>New>R Markdown… and choose from
`From Template` then `Report`.

## Datasets

### FTSE 350 data

The package includes point in time FTSE350 data from 2016-2020,
downloaded from Refinitiv Datastream for teaching purposes only. The
data has been used to create two return series 1. A point in time Top 25
by average market value returns series 2. A current Top 30 by market
capitalisation returns series

``` r
fml::ftse350
fml::ftse30_returns_mthly
fml::ftse25_rtns_mthly
```

### Daily uk asset pricing risk factors

These are created by Essex university business school and downloaded
from UK Data Service API.

``` r
fml::daily_factors"
```
