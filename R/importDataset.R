#' Imports a dataset into Traitbase.
#'
#' @param cnx The connection to traitbase service.
#' @param csvData The data in cvs format (string)
#'
#' @return Returns a list of errors if any. valid=(true|false), imported=false
#' @export
#' @examples
#' \donttest{
#' cnx <- connect('http://www.traitbase.info')
#' fpath <- system.file('extdata', 'sample-error.csv', package='traitbaser')
#' csvData <- readLines(fpath)
#' errors <- importDataset(cnx, csvData)
#' }

importDataset <- function(cnx, csvData) {
    privateImport(cnx, csvData, FALSE)
}
