#' Converts returned JSON data into an R dataframe.
#'
#' Private function. Converts returned JSON data into an R dataframe.
#'
#' @param response The raw response data after a query.
#' @param keep_metadata Flag to indicate if metadatata should be handled.
#'  Suported values are:
#'     - 'clean'     -  remove metadata (default one)
#'     - 'raw'       -  remove metadata
#'     - 'raw_links' -  remove metadata links
#'
#' @return \code{resource()} returns a resource object for a Hivepod backend.
#' This resource object can be used to make queries, count and manipulate data in the backend.
#' @examples
#' \donttest{
#' cnx <- connect('http://www.traitbase.info')
#' sp <- resource(cnx, 'species')
#' ds <- resource(cnx, 'datasets')
#' cont <- resource(cnx, 'contributors')
#' }

to_dataframe <- function(response, keep_metadata = "clean") {

    keep_metadata <- match.arg(keep_metadata,  c("clean", "raw", "raw_links"))
    responseNA <- lapply(response, nullToNA)
    dat <- unlist(responseNA)
    ##
    if (length(responseNA)) {
        nvariales <- length(unlist(responseNA[[1L]]))
        ncases <- length(responseNA)
        datamatrix <- matrix(data = dat, nrow = ncases, ncol = nvariales,
            byrow = TRUE)
        colnames(datamatrix) <- names(unlist(responseNA[[1L]]))
        datamatrix <- as.data.frame(datamatrix)
        utils::head(datamatrix)
        ##
        idnum <- grep("_id", colnames(datamatrix), fixed = TRUE)
        links <- grep("_links.", colnames(datamatrix), fixed = TRUE)
        optionalsid <- grep("_", colnames(datamatrix), fixed = TRUE)
        optionals <- optionalsid[-which(optionalsid == idnum)]
        ##
        out <- switch(keep_metadata,
            clean = datamatrix[, -optionals],
            raw = datamatrix[, -links],
            raw_links = datamatrix
        )
    } else out <- NULL
    out
}
