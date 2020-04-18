
contributor2 <- function(cnx, list_species) {


  off <- resource(cnx, "dataSets")
  df_dataset = query(off)

  urlbase <- httr::handle(off[[1L]])
  aut <- httr::authenticate(off[[2L]], off[[3L]])

  for (i in 1:nrow(df_dataset)){

    q1 <- httr::GET(handle = urlbase, config = aut, path = paste0("api/dataSets/",df_dataset$`_id`[i],"/references"))
    dataQ1 <- httr::content(q1, type = "application/json")
    df_aux <-  toDataframe(dataQ1)
    df_aux$dataSet <- df_dataset$`_id`[i]

    df_aux <- data.frame(lapply(df_aux, as.character), stringsAsFactors=FALSE)

    if (i==1){
      df_aux_final <- df_aux

    }else{
      df_aux_final <- dplyr::bind_rows(df_aux_final,df_aux)
    }
  }
  df_aux_final$contributor_name <- paste(df_aux_final$name,df_aux_final$lastname,sep=" ")

  names(df_dataset)[names(df_dataset) == "_id"] <- "dataSet"
  names(df_dataset)[names(df_dataset) == "name"] <- "dataSet_name"
  df_aux_final = merge(df_aux_final[, c("dataSet","orcid","contributor_name")],
                       df_dataset[, c("dataSet","credit","description","doi","dataSet_name")],
                       all.x = TRUE, by="dataSet")


  off <- resource(cnx, "observations")
  df_observation <-  query(off)
  names(df_observation)[names(df_observation) == "_id"] <- "observation"
  df_aux_final = merge(df_aux_final,
                       df_observation[, c("dataSet","observation","country","date","day","locationDescription",
                                      "month","originalSpecies","specie","year")],
                       all.x = TRUE, by="dataSet")

  df_final <- df_aux_final[df_aux_final$specie %in% list_species,]

  df_final[ df_final == "NA NA" ] <- NA
  df_final[ df_final == "NA" ] <- NA

return(df_final)

}
