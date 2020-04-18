#' Validates a dataset prior an import operation.
#'
#' @param cnx The connection to traitbase service.
#' @param csvData The data in cvs format (string) #Also accepts data.frame
#'
#' @return Returns a list of errors if any. valid=(true|false), imported=false
#' @export
#' @examples
#' \donttest{
#' cnx <- connect('http://www.traitbase.info')
#' fpath <- system.file('extdata', 'sample-error.csv', package='traitbaser')
#' csvData <- readLines(fpath)
#' errors <- validateDataset(cnx, csvData)
#' }

validateDataset <- function(cnx, csvData) {
    privateImport(cnx, csvData, TRUE)
}
