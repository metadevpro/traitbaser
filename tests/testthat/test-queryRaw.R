context("queryRaw")

test_that("raw query", {
  cnx <- connect("http://www.traitbase.info", "demo", "1234")
  resource <- resource(cnx, "species")
  out <- queryRaw(resource, "?limit=2&skip=1")
  expect_equal(2, nrow(out))
  expect_equal(8, ncol(out))
})
