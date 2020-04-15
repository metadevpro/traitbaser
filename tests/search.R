library(plyr)

getMeasures <- function(x) {
  obsID  = x$`_id`
  out = data.frame(obsID)
  meas   = x$measures
  for(m in meas) {
    trait = paste("m_", m$trait, sep="")
    out[trait]=m$value
  }
  out
}

search <- function(cnx, species = "all", traits = "all") {

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

  # Retrieve observations
  off <- resource(cnx, "observations")
  if (species == "all") {
    dfObservations = query(off)
  } else {
    dfObservations = query(off, conditions = buildCondition("originalSpecies", "==", species) )
  }

  # LEFT JOIN, add species data into observations data
  names(dfSpecies)[names(dfSpecies) == "_id"] <- "specie"
  dfOut = merge(dfObservations,
                dfSpecies[, c("specie","genus","species","order","superfamily","family","tribe","subgenus")],
                all.x = TRUE, by="specie")

  # Add dataset info
  off <- resource(cnx, "dataSets")
  dfDatasets = query(off)
  names(dfDatasets)[names(dfDatasets) == "_id"] <- "dataSet"
  dfOut = merge(dfOut,
                dfDatasets[, c("dataSet","credit","description","doi","name")],
                all.x = TRUE, by="dataSet")

  # Add contributors info
  # TODO: aquí, en teoría solo un contributor por dataSet? Como nos aseguramos que es único

  # Add traits info
  off <- resource(cnx, "observations")
  #IB: Repetitive?
  listObserv <- queryList(off, conditions = buildCondition("originalSpecies", "==", species))
#IB Aqui falta el if de species "all".
  measures = as.data.frame(do.call(rbind, lapply(listObserv, getMeasures)))
  dfOut = merge(dfOut,
                measures,
                all.x = TRUE, by.x="_id", by.y="obsID")
#IB: Aqui se podria filtrar por trait.
  return(dfOut)
}
