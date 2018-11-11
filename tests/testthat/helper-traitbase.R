# https://cran.r-project.org/web/packages/httr/vignettes/secrets.html
skip_if_no_auth <- function() {
    tmp <- c(
      identical(Sys.getenv("TRAITBASE_USER"), ""),
      identical(Sys.getenv("TRAITBASE_PWD"), "")
    )
    if (sum(tmp)) skip("Login is missing")
}

ut_pause <- function(x = 5) Sys.sleep(x)
