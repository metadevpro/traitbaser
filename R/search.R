#search <- function(cnx, species = "all", traits = "all") {

  # Retrieve species
  off <- resource(cnx, "species")
  if (species == "all") {
    dfSpecies = query(off)
  } else {
    dfSpecies = query(off, conditions = buildCondition("species", "==", species) )
  }
  if (!is.null(dfSpecies)) {
    idSpecies = dfSpecies$'_id'
  } else {
    print(paste("Warning: failed search of species:", species))
    return(NULL)
  }

  emptyDf = TRUE
  for (id in idSpecies) {
    # Retrieve observations
    off <- resource(cnx, "observations")
    dfObservations <- query(off, conditions = buildCondition("specie", "==", id) )

    if (!is.null(dfObservations)) {
      # LEFT JOIN, add species data into observations data
      colsSpecies = dfSpecies[dfSpecies$'_id' == id,]
      names(colsSpecies)[names(colsSpecies) == "_id"] <- "specie"
      dfObservations = merge(dfObservations,
                             colsSpecies[, c("specie","genus","species","order","superfamily","family","tribe","subgenus")],
                             all.x = TRUE, by="specie")

      if (emptyDf) {
        dfOut = dfObservations
        emptyDf = FALSE
      } else {
        dfOut = rbind(dfOut, dfObservations)
      }
    }

  }




  # Retrieve data sets
  off <- resource(cnx, "dataSets")
  dfDatasets <- query(off)

  # Retrieve contributors
  off <- resource(cnx, "contributors")
  dfContributors <- query(off)


#}
