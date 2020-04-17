
contributor <- function(cnx, list_species) {

  # Contributors info
  off <- resource(cnx, "contributors")
  df_contributors = query(off)

  # Do not compile the full list of contributors for 19733 species. A connection problem appears
  #after several contributor scrapings.

  if (length(list_species) > 400) {
    print(paste("Error: The total amount of species IDs should be less than or equal to 400"))
    return(NULL)
  }

  # # Datasets info
  # off <- resource(cnx, "dataSets")
  # df_datasets = query(off)

  # Get contributors info for each species

  for (i in 1:length(list_species)){

    #Access website and get html

    url_base = paste0(cnx[[1]][1],"query/species/")
    url = paste0(url_base,list_species[i])
    html_species <- xml2::read_html(url)


    #html to text
    text <- html_text(html_species)

    #Parse html

    #Identify contributors
    contributors <- strapplyc(text, "\"contri(.*?),\"stats", simplify = c)
    contributors <- strapplyc(contributors, "{\"_i(.*?)\"}", simplify = c)
    contributors <- stringr::str_remove_all(paste(contributors, collapse=''), "cid")
    contributors <- strapplyc(contributors , "d\":\"(.*?)\",\"name", simplify = c)

    #Identify species's name
    name <- strapplyc(text, "\"species\":\"(.*?)\",\"order", simplify = c)

    # #Identify observations
    # observations <- strapplyc(text, "\"observ(.*?),\"datasets\":", simplify = c)
    # observations_f <- strapplyc(observations, "{\"_id\":\"(.*?)\",\"date", simplify = c)
    #
    # #Identify dataset of each observation
    # dataset_observations_f <- strapplyc(observations, "\"dataSet\":\"(.*?)\",\"specie", simplify = c)

    # data_observations = search(cnx, species=name, traits="all")

    df_aux <- data.frame(
      id_species = rep(list_species[i], length(contributors)),
      name_species = rep(name, length(contributors)),
      id = contributors, stringsAsFactors = F )

    names(df_aux) <- c("_id_species","name_species","_id_contributor")

    #Add contributors info
    names(df_contributors)[names(df_contributors) == "_id"] <- "_id_contributor"
    df_aux = merge(df_aux,
                  df_contributors[, c("_id_contributor","name","lastname","orcid")],
                  all.x = TRUE, by="_id_contributor")

    if (i==1){
      df_aux_final <- df_aux
      # data_observations_final <- data_observations
    }else{
      df_aux_final <- dplyr::bind_rows(df_aux_final,df_aux)
      # data_observations_final <- dplyr::bind_rows(data_observations_final,data_observations)
    }
  }

  # return(list(df_aux_final, data_observations_final))
  return(df_aux_final)
}
