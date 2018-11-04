
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
