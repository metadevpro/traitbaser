#' Login helper function
#'
#' Set and forget the user name and the password to be connected to the
#' Traitbase API.
#'
#' @param user a character string containing the user name.
#' @param pwd a character string containing the password name.
#'
#' @detail
#' `set_login()` sets the environmental variables  `TRAITBASE_USER`, `TRAITBASE_PWD`
#' for the current R session. Note that if you want to set then permanently,
#' you can add them in `.Renviron`, or your `.Rprofile` (see `Startup`).
#' `set_login()` retrieves `TRAITBASE_USER`, `TRAITBASE_PWD` and calls `set_login()`
#' if not set.
#'
#' @export
#'
#' @examples
#' \donttest{
#'  # NB the password below is false.
#'  set_login(user = 'KevCaz', pwd = 'you')
#'  # interactively
#'  forget_login()
#' }
#' @describeIn set_login set the environment variable `SPECIESPLUS_TOKEN`.

set_login <- function(user = NULL, pwd = NULL) {
    if (is.null(user)) 
        user <- readline("Enter your user name without quotes: ")
    stopifnot(user != "")
    ## 
    if (is.null(pwd)) 
        pwd <- readline("Enter your password without quotes: ")
    stopifnot(pwd != "")
    ## 
    Sys.setenv(TRAITBASE_USER = user, TRAITBASE_PWD = pwd)
    ## 
    cat("Now user and password are stored for the session.\n")
    invisible(c(user, pwd))
}

#' @describeIn set_login forget the environment variables `TRAITBASE_USER' and 'TRAITBASE_PWD`.
#' @export
forget_login <- function() Sys.unsetenv(c("TRAITBASE_USER", "TRAITBASE_PWD"))

#' @describeIn set_login get the environment variables `TRAITBASE_USER' and 'TRAITBASE_PWD`, calls
#' @export
get_login <- function(user = NULL, pwd = NULL) {
    if (is.null(user)) 
        user <- get_login_from_env(user, "TRAITBASE_USER")
    if (is.null(pwd)) 
        pwd <- get_login_from_env(pwd, "TRAITBASE_PWD")
    if (is.null(user) | is.null(pwd)) 
        out <- set_login(user, pwd) else out <- c(user, pwd)
    out
}

get_login_from_env <- function(val, env) {
    if (is.null(val)) {
        if (!identical(Sys.getenv(env), "")) 
            val <- Sys.getenv(env)
    }
    val
}
