require("httr")

#' Creates a connection.
#'
#' Setup a connection to a given Traitbase backend with credentials.
#'
#' @param url The base URL to connect to. Default value: https://traitbase.info
#' @param user The user credential.
#' @param pass The password for the user.
#'
#' @return connect returns a connection object for a Traitbase backend.
#' This connection object can be used to discover and access to resources.
#' @export
#' @examples
#' \donttest{
#' # not run
#' cnx <- connect('http://www.traitbase.info', 'demo', '1234')
#' }

connect <- function(url = "http://www.traitbase.info", user = "demo", pass = "") {
    urlbase <- httr::handle(url)
    rping <- httr::GET(handle = urlbase, path = "ping")
    dataPing <- httr::content(rping, type = "application/json")

    status <- httr::GET(handle = urlbase, config = httr::authenticate(user,
        pass), path = "api/status")
    dataQ1 <- httr::content(status, type = "application/json")

    list(url, user, pass, status)
}
