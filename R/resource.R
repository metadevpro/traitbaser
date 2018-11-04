#' Creates a resource.
#'
#' Setups and returns a resource available in a Hivepod backend.
#'
#' @param connection The connection created with the \code{connect()} function.
#' @param resourceName The resource name used in Hivepod. Note that is uses to be a plural name.
#'
#' @return \code{resource()} returns a resource object for a Hivepod backend.
#' This resource object can be used to make queries, count and manipulate data in the backend.
#' @export
#' @examples
#' \donttest{
#' cnx <- connect('http://www.traitbase.info', 'demo', '1234')
#' exo <- resource(cnx, 'species')
#' whe <- resource(cnx, 'schemas')
#' }
resource <- function(connection, resourceName) {
    c(connection[seq_len(4), resourceName)
}
