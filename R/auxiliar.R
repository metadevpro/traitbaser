# Private Auxiliar functions. -------------------------- Not exposed in
# the public package API.

nullToNA <- function(x) {
    x[unlist(lapply(x, is.null))] <- NA
    x
}

urlEncode <- function(value) {
    if (is.null(value)) {
        out <- "null"
    } else {
        out <- switch(mode(value), character = paste0("\"", utils::URLencode(value),
            "\""), logical = tolower(as.character(value)), value)
    }
    out
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
    urlbase <- httr::handle(cnx[[1L]])
    aut <- httr::authenticate(cnx[[2L]], cnx[[3L]])
    url <- "/api/import/dataset"
    mime <- httr::add_headers(`content-type` = "text/csv")

    txtData <- ifelse(is.data.frame(csvData), df2csv(csvData), csvData)

    if (validateOnly) {
        url <- paste0(url, "?validateOnly=true")
    }

    httr::with_config(aut, httr::with_config(mime, q1 <- httr::POST(path = url,
        body = txtData, encode = "raw", handle = urlbase)))

    httr::content(q1, type = "application/json")
}



#### Conversion to dataframe ####

## Converts the list of data the traitbase returs into a data frame.
response <- dataQ1

toDataframe <- function(response) {
  ##
  responseNA <- lapply(
    lapply(response, nullToNA),
    ## _links is the only list so I remove it here
    Filter, f = Negate(is.list)
  )
  if (length(responseNA)) {
    nm <- unique(unlist(lapply(responseNA, names)))
    ## add names if missing + rbind
    out <- as.data.frame(
      do.call(rbind,
        lapply(
          lapply(responseNA, addNames, nm),
          do.call, what = cbind
        )
      )
    )
    class(out) <- c("tbl_df", "tbl", "data.frame")
  } else out <- NULL
  ##
  out
}

addNames <- function(x, nm) {
  tmp <- setdiff(nm, names(x))
  if (!is.null(tmp)) x[tmp] <- NA
  x
}

parseLinks <- function(response) {
  if (length(response)) {
    ## NB _links is the only list
    out <- as.data.frame(
      do.call(
        rbind,
        lapply(
          lapply(response, Filter, f = is.list),
          unlist)
        )
      )
    names(out) <- gsub("_links.", "", names(out), fixed = TRUE)
    class(out) <- c("tbl_df", "tbl", "data.frame")
  } else out <- NULL
  out
}
