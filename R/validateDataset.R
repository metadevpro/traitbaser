require("httr")

#' Validates a dataset prior an import operation.
#'
#' @param cnx The connection to traitbase service.
#' @param csvData The data in cvs format (string)
#'
#' @return Returns a list of errors if any. valid=(true|false), imported=false
#' @export
#' @examples
#' cnx <- connect("http://www.traitbase.info", "demo", "1234")
#' csvData <- read.csv2("../../data/sample-error.csv")
#' errors <- validateDataset(cnx, csvData)

validateDataset <- function(cnx, csvData) {
  res <- privateImport(cnx, csvData, TRUE)
  return (res)
}
