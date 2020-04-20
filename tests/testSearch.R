
#library(devtools)
#install_github("metadevpro/traitbaser")
library(traitbaser)

source("R/auxiliar.R")
source("R/query.R")
source("tests/search.R")
source("tests/queryList.R")
source("tests/contributor.R")
cnx <- connect(url = "https://traitbase-dev.herokuapp.com/", "root", "bee4") #demo not working
dfOsmiaCaerulescens = search(cnx, species="Osmia caerulescens", traits="all")
head(dfOsmiaCaerulescens)
dfAll = search(cnx, species="all", traits="all")
head(dfAll)
dfAll = search(cnx, species="all", traits="all", showID = TRUE)
head(dfAll)


