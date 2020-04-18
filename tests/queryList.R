queryList <- function(resource, limit = -1, skip = 0, conditions = NULL, sort,
                      selectFields, distinct) {
  urlbase <- httr::handle(resource[[1L]])
  aut <- httr::authenticate(resource[[2L]], resource[[3L]])

  query <- ""
  prefix <- "?"
  if (limit != -1) {
    query <- paste0(prefix, "limit=", limit)
    prefix <- "&"
  }
  if (skip != 0) {
    query <- paste0(query, prefix, "skip=", skip)
    prefix <- "&"
  }
  if (!is.null(conditions)) {
    query <- paste0(query, prefix, buildQueryConditions(conditions))
    prefix <- "&"
  }

  q1 <- httr::GET(handle = urlbase, config = aut, path = paste("api/",
                                                               resource[[5]], query, sep = ""))
  dataQ1 <- httr::content(q1, type = "application/json")
  ## output
  dataQ1
}

queryInternal <- function(resource, pathInternal, todataframe = TRUE) {
    urlbase <- httr::handle(resource[[1L]])
    aut <- httr::authenticate(resource[[2L]], resource[[3L]])

    q1 <- httr::GET(handle = urlbase, config = aut, path = pathInternal)
    dataQ1 <- httr::content(q1, type = "application/json")
    ## output
    if(todataframe){
      out <- toDataframe(dataQ1)
    } else {
      out <- dataQ1
    }
    return(out)
  }
