context("resource")
skip_on_cran()
skip_if_no_auth()

cnx <- connect("http://www.traitbase.info")

test_that("select resource species", {
  out <- resource(cnx, "species")
  expect_equal(TRUE, is.list(out))
  expect_equal("species", out[[5]])
})

test_that("select resource species", {
  out <- resource(cnx, "species")
  expect_equal(TRUE, is.list(out))
  expect_equal("species", out[[5]])
})
