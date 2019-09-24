#' Deelet a dataset from Traitbase.
#'
#' @param cnx The connection to traitbase service.
#' @param datasetId The ID of the dataset to delete
#'
#' @return Returns a list of errors if any or OK.
#' @export
#' @examples
#' \donttest{
#' datasetId <- '5d8a33d15fe80e52902098e3'
#' cnx <- connect('http://www.traitbase.info')
#' errors <- importDataset(cnx, datasetId)
#' }

deleteDatasetById <- function(cnx, datasetId) {
  privateDeleteDatasetById(cnx, datasetId)
}
