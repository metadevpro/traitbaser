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
#' cnx <- connect("http://jacaton-r.herokuapp.com", "demo", "1234")
#' exo <- resource(cnx, "exoplanets")
#' whe <- resource(cnx, "wheathers")
#' oly <- resource(cnx, "olympicMedals")

resource <-  function(connection, resourceName) {
  res <- list(connection[[1]], connection[[2]], connection[[3]],connection[[4]], resourceName)
  return (res)
}
