# Private Auxiliar functions. -------------------------- Not exposed in
# the public package API.

nullToNA <- function(x) {
    x[unlist(lapply(x, is.null))] <- NA
    x
}


buildQueryConditions <- function(conditionList = NULL) {
    if (is.null(conditionList)) {
        return(NA)
    }
    res <- "conditions={"
    prefix <- ""

    for (i in 1:length(conditionList)) {
        res <- paste0(res, prefix, conditionList[i])
        prefix = ","
    }

    paste0(res, "}")
}

# encode a dataframe to a CSV string
df2csv <- function(df) {
    lines <- utils::capture.output(utils::write.csv(df, stdout(), row.names = FALSE,
        na = ""))
    paste(lines, collapse = "\n")
}

# add quotes if text contains comma or quotes also double escape quotes
# if present
protectCommas <- function(data) {
    if (grepl(",|\"", data)) {
        data2 <- gsub("\"", "\"\"", data)  # escape quote (') as ('')
        return(paste0("\"", data2, "\""))  # wrap on quotes
    }
    data
}


# encode literal for CSV
quote4csv <- function(data) {
  if (is.logical(data)) {
      data <- ifelse(data, "true", "false")
  } else {
    data <- protectCommas(paste0("", data))
  }
  data
}


privateImport <- function(cnx, csvData, validateOnly = TRUE) {
    urlbase <- httr::handle(cnx[[1]])
    aut <- httr::authenticate(cnx[[2]], cnx[[3]])
    url <- "/api/import/dataset"
    mime <- httr::add_headers(`content-type` = "text/csv")

    if (is.data.frame(csvData)) {
        txtData = df2csv(csvData)
    } else {
        txtData = csvData
    }

    if (validateOnly) {
        url <- paste0(url, "?validateOnly=true")
    }

    httr::with_config(aut, httr::with_config(mime, q1 <- httr::POST(path = url,
        body = txtData, encode = "raw", handle = urlbase)))

    httr::content(q1, type = "application/json")
}
