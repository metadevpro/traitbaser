library(traitbaser)
library(rvest)
library(gsubfn)

source("R/auxiliar.R")
source("tests/search.R")
source("tests/queryList.R")
source("tests/contributor.R")

# Site for development tests

list_species_dev = c("589322e150271204003cf066","589323b650271204003cf11c","589323bd50271204003cf11f")

# Andrena agilissima: 589322e150271204003cf066 -> dev. site: No contributors
# Bombus pascuorum: 589322e150271204003cf066 -> dev: 5 contributors
# Halictus rubicundus: 589323bd50271204003cf11f -> dev: 5 contributors

cnx_dev <- connect(url = "https://traitbase-dev.herokuapp.com/", "root", "bee4")
df_contributors_dev = contributor(cnx_dev, list_species_dev)
head(df_contributors_dev)

########################################

# Real site

list_species = c("5b04107a2265c5000fab1b98","5b04145b2265c5000fab2a7f","5b0414942265c5000fab49e4")

# Andrena agilissima: 5b04107a2265c5000fab1b98 -> real site: 17 contr.
# Bombus pascuorum: 5b04145b2265c5000fab2a7f -> dev: 5 contributors, real: 47
# Halictus rubicundus: 5b0414942265c5000fab49e4 -> dev: 5 contributors, real: 52


cnx <- connect(url = "https://traitbase.info/", "root", "bee4")
df_contributors_real = contributor(cnx, list_species)
head(df_contributors_real)
