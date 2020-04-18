
contributor2 <- function(cnx, list_species) {


  off <- resource(cnx, "dataSets")
  df_dataset = query(off)

  urlbase <- httr::handle(off[[1L]])
  aut <- httr::authenticate(off[[2L]], off[[3L]])

  #Get contributors from each dataset by making individual queries

  for (i in 1:nrow(df_dataset)){

    q1 <- httr::GET(handle = urlbase, config = aut, path = paste0("api/dataSets/",df_dataset$`_id`[i],"/references"))
    dataQ1 <- httr::content(q1, type = "application/json")
    df_aux <-  toDataframe(dataQ1)

    if(is.null(df_aux)){df_aux <- data.frame(`__v`=NA,`_createdAt`=NA,`_id`=NA,
                                             lastname=NA,name=NA,orcid=NA)}

    df_aux$dataSet <- df_dataset$`_id`[i]
    df_aux$n_con <- seq.int(nrow(df_aux))
    df_aux <- data.frame(lapply(df_aux, as.character), stringsAsFactors=FALSE)

    if (i==1){
      df_aux_final <- df_aux

    }else{
      df_aux_final <- dplyr::bind_rows(df_aux_final,df_aux)
    }
}

  # Spreading contributors info

  df_aux_final$contributor_name <- paste(df_aux_final$name,df_aux_final$lastname,sep=" ")
  names(df_aux_final)[names(df_aux_final) == "X_id"] <- "contributor_id"
  df_aux_final <- df_aux_final[,c("dataSet","n_con","orcid","contributor_name","contributor_id")]

  df_aux_final <- df_aux_final %>% gather(variable, value, -(dataSet:n_con))%>%
    unite(temp, variable, n_con)%>%
    spread(temp, value)

  df_aux_final[df_aux_final == "NA NA"] <- NA
  df_aux_final[df_aux_final == "NA"] <- NA

  # Adding dataset info

  names(df_dataset)[names(df_dataset) == "_id"] <- "dataSet"
  names(df_dataset)[names(df_dataset) == "name"] <- "dataSet_name"

  df_aux_final = merge(df_dataset[, c("dataSet","credit","description","doi","dataSet_name")],
                       df_aux_final,
                       all.x = TRUE, by="dataSet")


  # Adding observations' data

  off <- resource(cnx, "observations")
  df_observation <-  query(off)
  names(df_observation)[names(df_observation) == "_id"] <- "observation_id"

  df_aux_final = merge(df_observation[, c("dataSet","observation_id","country","date","day","locationDescription",
                                          "month","originalSpecies","specie","year")],
                       df_aux_final,
                       all.x = TRUE, by="dataSet")

  # Filtering species

  df_final <- df_aux_final[df_aux_final$specie %in% list_species,]

  row.names(df_final) <- 1:nrow(df_final)


return(df_final)

}
