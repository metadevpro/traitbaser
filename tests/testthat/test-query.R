context("query")

test_that("query species", {
  cnx <- connect("http://www.traitbase.info", "demo", "1234")
  resource <- resource(cnx, "species")
  out <- query(resource)
  expect_equal(TRUE, length(out) > -1)
  expect_equal(9, ncol(out))
})

test_that("query species limit=1", {
  cnx <- connect("http://www.traitbase.info", "demo", "1234")
  resource <- resource(cnx, "species")
  out <- query(resource, limit=1)
  expect_equal(1, nrow(out))
  expect_equal(9, ncol(out))
})

test_that("query species limit=2 skip=1", {
  cnx <- connect("http://www.traitbase.info", "demo", "1234")
  resource <- resource(cnx, "species")
  out <- query(resource, limit=2, skip=1)
  expect_equal(2, nrow(out))
  expect_equal(9, ncol(out))
})

test_that("query species limit=1 names", {
  cnx <- connect("http://www.traitbase.info", "demo", "1234")
  resource <- resource(cnx, "species")
  out <- query(resource, limit=1)
  n <- names(out)
  expect_equal(1, nrow(out))
  expect_equal("_id", n[[1]])
  expect_equal("species", n[[2]])
  expect_equal("order", n[[3]])
})

test_that("query species limit=1 with condition", {
  cnx <- connect("http://www.traitbase.info", "demo", "1234")
  resource <- resource(cnx, "species")
  out <- query(resource, limit=1, conditions=buildCondition("genus", "==", "unit-test-sample" ))
  expect_equal(NULL, nrow(out))
})
