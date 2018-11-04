# Private Auxiliar functions. -------------------------- Not exposed in
# the public package API.


nullToNA <- function(x) {
    x[sapply(x, is.null)] <- NA
    x
}

urlEncode <- function(value) {
    if (mode(value) == "numeric") {
        value <- value
    }
    if (is.character(value)) {
        value <- paste0("\"", utils::URLencode(value), "\"")
    }
    if (is.logical(value)) {
        value <- ifelse(value, "true", "false")
    }
    if (is.null(value)) {
        value <- "null"
    }
    value
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
    text <- paste(lines, collapse = "\n")
    text
}


# encode literal for CSV
quote4csv <- function(data) {
    if (mode(data) == "numeric") {
        return(toString(data))
    }
    if (mode(data) == "character") {
        return(protectCommas(data))
    }
    if (is.logical(data)) {
        data <- ifelse(data, "true", "false")
    }
    if (is.null(data)) {
        return("")
    }
    data
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
