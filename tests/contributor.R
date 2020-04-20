
path_query <- function(connection, resourceName, item, list_items = "all"){

  off <- resource(connection, resourceName)

  if (list_items[1] == "all"){
    df_resource <-  query(off)
    return(df_resource)

  }else if (length(list_items)==1){

      # path for API
      path_test = paste0("api/",resourceName,"?conditions={\"",item,"\":\"",list_items[1],"\"}")
      df_resource <-  queryInternal(off,path_test)
      return(df_resource)

  }else{

      # path for API
      path_test <-  paste0("api/",resourceName,"?conditions={\"",item,"\":[")
      for (i in 1:(length(list_items)-1)){
        path_test <- paste0(path_test,"\"",list_items[i],"\",")
      }
      path_test <- paste0(path_test,"\"",list_items[length(list_items)],"\"]}")
      df_resource <-  queryInternal(off,path_test)
      return(df_resource)
    }
}
###################


contributor <- function(cnx, vector_species = "all") {

  #Get observation data for a given vector_species
  df_observation <-  path_query(cnx, "observations", "specie",vector_species)

  #Get datasets info for previous observations
  list_dataSets <- as.character(unique(df_observation$dataSet))

  df_dataset <-  path_query(cnx, "dataSets", "_id", list_items = list_dataSets)

  off <- resource(cnx, "dataSets")
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
      df_final <- df_aux

    }else{
      df_final <- dplyr::bind_rows(df_final,df_aux)
    }
  }

  # Spreading contributors info

  df_final$contributor_name <- paste(df_final$name,df_final$lastname,sep=" ")
  names(df_final)[names(df_final) == "X_id"] <- "contributor_id"
  df_final <- df_final[,c("dataSet","n_con","orcid","contributor_name","contributor_id")]

  df_final <- df_final %>% gather(variable, value, -(dataSet:n_con))%>%
    unite(temp, variable, n_con)%>%
    spread(temp, value)

  df_final[df_final == "NA NA"] <- NA
  df_final[df_final == "NA"] <- NA

  # Adding dataset info

  names(df_dataset)[names(df_dataset) == "_id"] <- "dataSet"
  names(df_dataset)[names(df_dataset) == "name"] <- "dataSet_name"

  df_final = merge(df_dataset[, c("dataSet","credit","description","doi","dataSet_name")],
                       df_final,
                       all.x = TRUE, by="dataSet")


  # Adding observations' data

  names(df_observation)[names(df_observation) == "_id"] <- "observation_id"

  df_final = merge(df_observation[, c("dataSet","observation_id","country","date","day",
                                          "month","originalSpecies","specie","year")],
                       df_final,
                       all.x = TRUE, by="dataSet")


  row.names(df_final) <- 1:nrow(df_final)


  return(df_final)
}
