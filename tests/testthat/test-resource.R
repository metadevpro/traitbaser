context("resource")

test_that("select resource species", {
  cnx <- connect("http://www.traitbase.info", "demo", "1234")
  out <- resource(cnx, "species")
  expect_equal(TRUE, is.list(out))
  expect_equal("species", out[[5]])
})

test_that("select resource species", {
  cnx <- connect("http://www.traitbase.info", "demo", "1234")
  out <- resource(cnx, "species")
  expect_equal(TRUE, is.list(out))
  expect_equal("species", out[[5]])
})

