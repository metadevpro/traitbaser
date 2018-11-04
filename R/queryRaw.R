#' Makes a raw query
#'
#' Executes a query allowing pasing a direct Hivepod/Baucis query using JSON
#' syntax as defined here:
#' https://github.com/wprl/baucis/wiki/Query-String-Parameters
#'
#' @param resource The resource to query.
#' @param query Raw URL query. See doc here: https://github.com/wprl/baucis/wiki/Query-String-Parameters
#'
#' @return Returns a dataframe with the returned data.
#' @export
#' @examples
#' cnx <- connect('http://www.traitbase.info', 'demo', '1234')
#' spe <- resource(cnx, 'species')
#'
#' queryRaw(spe, '?skip=2&limit=3')

queryRaw <- function(resource, query) {
    urlbase <- httr::handle(resource[[1L]])
    aut <- httr::authenticate(resource[[2L]], resource[[3L]])
    q1 <- httr::GET(handle = urlbase, config = aut, path = paste("api/", 
        resource[[5L]], query, sep = ""))
    dataQ1 <- httr::content(q1, type = "application/json")
    ## output
    to_dataframe(dataQ1)
}
