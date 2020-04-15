
#library(devtools)
#install_github("metadevpro/traitbaser")
library(traitbaser)

source("R/auxiliar.R")
source("tests/search.R")
source("tests/queryList.R")
cnx <- connect(url = "https://traitbase-dev.herokuapp.com/", "root", "bee4") #demo not working
dfOsmiaCaerulescens = search(cnx, species="Osmia caerulescens", traits="all")


