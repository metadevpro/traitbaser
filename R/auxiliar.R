# Private Auxiliar functions. --------------------------
# Not exposed in the public package API.


nullToNA <- function(x) {
  x[sapply(x, is.null)] <- NA
  return(x)
}



urlEncode <- function(value) {
  if (mode(value) == "numeric") {
    return (value)
  }
  if (mode(value) == "character") {
    return  (paste0("\"", URLencode(value), "\""))
  }
  if (mode(value) == "logical") {
    if (value==TRUE) {
      return ("true")
    } else {
      return ("false")
    }
  }
  if (is.null(value) ) {
    return ("null")
  }
  return (value)
}

buildQueryConditions <- function(conditionList=NULL) {
  if (is.null(conditionList)) {
    return(NA)
  }
  res <- "conditions={"
  prefix <-""

  for(i in 1:length(conditionList)) {
    res <- paste0(res, prefix, conditionList[i])
    prefix=","
  }

  res <- paste0(res, "}")
  return(res)
}
