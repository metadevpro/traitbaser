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

# encode a dataframe to a CSV string
df2csv <- function(df) {
  lines <- capture.output(write.csv(df, stdout(), row.names=FALSE, NA=""))
  text = paste(lines, collapse ="\n")
  return (text)
}


# encode literal for CSV
quote4csv <- function(data) {
  if (mode(data) == "numeric") {
    return (toString(data))
  }
  if (mode(data) == "character") {
    return (protectCommas(data))
  }
  if (mode(data) == "logical") {
    if (data == TRUE) {
      return ("true")
    } else {
      return ("false")
    }
  }
  if (is.null(data) ) {
    return ("")
  }
  return (data)
}

# add quotes if text contains comma or quotes
# also double escape quotes if present
protectCommas <- function(data) {
  if (grepl(",|\"", data)) {
    data2 <- gsub("\"", "\"\"", data)  # escape quote (") as ("")
    return (paste0("\"", data2, "\"")) # wrap on quotes
  }
  return (data)
}
