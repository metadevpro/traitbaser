require("httr")

#' Imports a dataset intro Traitbase.
#'
#' @param cnx The connection to traitbase service.
#' @param csvData The data in cvs format (string)
#'
#' @return Returns a list of errors if any. valid=(true|false), imported=false
#' @export
#' @examples
#' cnx <- connect("http://www.traitbase.info", "demo", "1234")
#' fpath <- system.file("extdata", "sample-ok.csv", package="traitbaser")
#' csvData <- readLines(fpath)
#' errors <- importDataset(cnx, csvData)

importDataset <- function(cnx, csvData) {
  res <- privateImport(cnx, csvData, FALSE)
  return (res)
}
