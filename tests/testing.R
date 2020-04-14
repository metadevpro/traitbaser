#test and play

#add---
library(devtools)
install_github("metadevpro/traitbaser")
library(traitbaser)
#cnx <- connect(url = "http://traitbase-qa.herokuapp.com/", "root", "bee4") #demo not working
cnx <- connect(url = "https://traitbase-dev.herokuapp.com/", "root", "bee4") #demo not working

#Add data-----
d <- read.csv("tests/testdata.csv", header = TRUE, sep = ";")
head(d)
errors <- validateDataset(cnx, d)
errors

parseErrors(errors)

#way to clean errors
#fix
#create helper functions
#temp <- clean_species(species = d$species[1:3])

#Fix one manually
d[7,"year"] <- 2019

#test one by one
d[7,]
parseErrors(validateDataset(cnx, d[7,-21]))
#FIX Error in paste error when no error.

importDataset(cnx, d[7,-21]) #works!


#consult----
#test query
off <- resource(cnx, "species")

query(off) #query all database.
query(off, conditions = buildCondition("genus", "==", "Bombus ")) #fix example query species for genus.
##FUCK genus has an space at the end FIX IN DATABASE!!!!
query(off, conditions = buildCondition("species", "==", "Bombus terrestris")) #fix example query species for genus.

query(off, limit=2, skip=0)
query(off, limit=2, skip=2)

#Recover the query we just enetered for Osmia rufa

# delete -----

#Fetch dataset ID
off <- resource(cnx, "dataSets") #Wierdspelling
out <- query(off)
datasetId <- out[7,1] #make safe
deleteDatasetById(cnx, datasetId)
#make better output






