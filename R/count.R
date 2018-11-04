#' Count the number of rows in a query.
#'
#' Returns the total count of rows in a query.
#'
#' @param resource The resource to query.
#' @param conditions A set of conditions to constraint the query on the server side. Use the function \code{buildCondition()} to create the conditions.0
#' @param distinct Provides a distict criteria. (Not yet implemented)
#'
#' @return Returns the total count of rows in a query.
#' @export
#' @examples
#' \donttest{
#' cnx <- connect('http://www.traitbase.info', 'demo', '1234')
#' off <- resource(cnx, 'species')
#'
#' count(off)
#' count(off, conditions=buildCondition('species', '!=', 'Bombus')  )
#' }

count <- function(resource, conditions = NULL, distinct = NULL) {

    urlbase <- httr::handle(resource[[1L]])
    aut <- httr::authenticate(resource[[2L]], resource[[3L]])

    query <- "?count=true"
    prefix <- "&"
    if (!is.null(conditions)) {
        query <- paste0(query, prefix, buildQueryConditions(conditions))
    }

    q1 <- httr::GET(handle = urlbase, config = aut, path = paste0("api/",
        resource[[5L]], query))
    ## output
    httr::content(q1, type = "application/json")
}
