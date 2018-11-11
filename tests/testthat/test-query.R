context("query")
skip_on_cran()
skip_if_no_auth()
cnx <- connect("http://www.traitbase.info")

test_that("query species", {
  resource <- resource(cnx, "species")
  out <- query(resource)
  expect_equal(TRUE, length(out) > -1)
  expect_equal(11, ncol(out))
})

test_that("query species limit=1", {
  out <- query(resource(cnx, "species"), limit=1)
  expect_true(all(dim(out) == c(1, 11)))
  expect_true(all(names(out)[1:3] == c("_id", "species", "order")))
})

test_that("query species limit=2 skip=1", {
  resource <- resource(cnx, "species")
  out <- query(resource, limit = 2, skip = 1)
  expect_true(all(dim(out) == c(2, 11)))
})

test_that("query species limit=1 with condition", {
  resource <- resource(cnx, "species")
  out <- query(resource, limit = 1,
    conditions = buildCondition("genus", "==", "unit-test-sample" ))
  expect_null(out)
})


context("queryRaw")

test_that("raw query", {
  cnx <- connect("http://www.traitbase.info")
  resource <- resource(cnx, "species")
  out <- queryRaw(resource, "?limit=2&skip=1")
  expect_true(all(dim(out) == c(2, 11)))
})
