
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
  off_obs <- resource(cnx, "observations")
  if (species == "all") {
    dfObservations = query(off_obs)
  } else {
    dfObservations = query(off_obs, conditions = buildCondition("originalSpecies", "==", species) )
  }
  names(dfObservations)[names(dfObservations) == "_id"] <- "observation_id"

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
  dfContributors = contributor(cnx, vector_species = idSpecies)
  dfOut = merge(dfOut,
                dfContributors[, c("observation_id", setdiff(names(dfContributors), names(dfOut)))],
                all.x = TRUE, by="observation_id")

  # Add traits info
  if (species == "all") {
    listObserv <- query(off_obs, todataframe = FALSE)
  } else {
    listObserv <- query(off_obs, conditions = buildCondition("originalSpecies", "==", species),
                        todataframe = FALSE)
  }
  measures = do.call(plyr::rbind.fill, lapply(listObserv, getMeasures))
  dfOut = merge(dfOut,
                measures,
                all.x = TRUE, by.x="observation_id", by.y="obsID")

#IB: Aqui se podria filtrar por trait.
  #Pero entiendo que es postprocesado, e-g trait = "IT" solo da m_IT.
#NOTA: Si quieres todas las observaciones con traits = "IT" requiere bajar todas las observaciones, verdad?
  #si es asi, no hace falta modificar nada más, pero puede ser lento cuando haya muchas observacions.
#NOTA: Falta una function to ask for metadata (basically query schema and traits databases)
#Tambien se podria añadir un parametro show_id = FALSE que esconda: _id, dataSet, specie,__v,_createdAt,
  #Se puede renombrar algun campo como: name -> dataset_name, dataset_credit, dataset_description
  #Se puede reordenar para que la taxonomia quede junta, las fechas tambien, etc...
  return(dfOut)
}
