
#library(devtools)
#install_github("metadevpro/traitbaser")
library(traitbaser)

source("R/auxiliar.R")
source("tests/search.R")
source("tests/queryList.R")
dfOsmiaCaerulescens = search(species="Osmia caerulescens", traits="all")


