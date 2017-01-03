#' Makes a query
#'
#' Executes a query on the server backend and returns data.
#'
#' @param resource The resource to query.
#' @param limit Limit the number of data rows to retrieve. If no specified, no limit applies.
#' @param skip Skip the first N data rows to retrieve. If no specified, no skip=0 is assumed.
#' @param conditions A set of conditions to constraint the query on the server side. Use the function \code{buildCondition()} to create the conditions.0
#' @param sort Criteria to sort the data returned. (Not yet implemented)
#' @param selectFields Select and filter the fields to retrieve (columns). (Not yet implemented)
#' @param distinct Provides a distict criteria. (Not yet implemented)
#'
#' @return Returns a dataframe with the returned data.
#' @export
#' @examples
#' cnx <- connect("http://www.traitbase.info", "demo", "1234")
#' off <- resource(cnx, "species")
#'
#' query(off)
#' query(off, conditions=buildCondition("species", "==", "Bombus")  )
#' query(off, limit=2, skip=0)
#' query(off, limit=2, skip=2)

query <- function(resource, limit=-1, skip=0, conditions=NULL, sort, selectFields, distinct) {
  urlbase <- httr::handle(resource[[1]])
  aut <- httr::authenticate(resource[[2]], resource[[3]])

  query <- ""
  prefix <- "?"
  if (limit!=-1) {
    query <- paste0(prefix, "limit=", limit)
    prefix <- "&"
  }
  if (skip!=0) {
    query <- paste0(query, prefix, "skip=", skip)
    prefix <- "&"
  }
  if (!is.null(conditions)) {
    query <- paste0(query, prefix, buildQueryConditions(conditions))
    prefix <- "&"
  }

  q1 <- httr::GET(handle=urlbase, config=aut, path=paste("api/", resource[[5]], query, sep="") )
  dataQ1 <- httr::content(q1, type="application/json")
  df <- to_dataframe(dataQ1)
  return (df)
}


