#' Creates a connection.
#'
#' Setup a connection to a given Traitbase backend with credentials.
#'
#' @param url The base URL to connect to. Default value: https://traitbase.info
#' @param user The user credential. Default is set to NULL
#' @param pwd The password for the user.
#'
#' @return connect returns a connection object for a Traitbase backend.
#' This connection object can be used to discover and access to resources.
#' @export
#' @examples
#' \donttest{
#' # not run
#'  cnx <- connect(url = 'http://www.traitbase.info')
#' }

connect <- function(url = "http://www.traitbase.info", user = NULL, pwd = NULL) {
    urlbase <- httr::handle(url)
    rping <- httr::GET(handle = urlbase, path = "ping")
    dataPing <- httr::content(rping, type = "application/json")
    ## 
    if (is.null(user) | is.null(pwd)) {
        tmp <- get_login(user, pwd)
        user <- tmp[1L]
        pwd <- tmp[2L]
    }
    ## 
    status <- httr::GET(handle = urlbase, config = httr::authenticate(user, 
        pwd), path = "api/status")
    dataQ1 <- httr::content(status, type = "application/json")
    ## 
    list(url, user, pwd, status)
}
