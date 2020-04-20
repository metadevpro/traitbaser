library(traitbaser)
library(tidyr)

source("R/auxiliar.R")
source("tests/search.R")
source("tests/queryList.R")
source("tests/contributor.R")

# Site for development tests

vector_species = c("589322e150271204003cf066","589323b650271204003cf11c","589323bd50271204003cf11f")

# Andrena agilissima: 589322e150271204003cf066 -> dev. site: No contributors
# Bombus pascuorum: 589322e150271204003cf066 -> dev: 5 contributors
# Halictus rubicundus: 589323bd50271204003cf11f -> dev: 5 contributors

cnx <- connect(url = "https://traitbase-dev.herokuapp.com/", "root", "bee4")

df_contributors_dev <-  contributor(cnx, vector_species)
head(df_contributors_dev)

df_contributors_dev <-  contributor(cnx, "all")
head(df_contributors_dev)
