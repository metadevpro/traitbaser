context("count")

test_that("count traits > -1", {
  cnx <- connect("http://www.traitbase.info")
  resource <- resource(cnx, "traits")
  out <- count(resource)
  expect_equal(TRUE, out > -1)
})

test_that("count species with genus=Andrena => 0", {
  cnx <- connect("http://www.traitbase.info")
  resource <- resource(cnx, "species")
  out <- count(resource, conditions=buildCondition("genus", "==", "Andrena"))
  expect_equal(TRUE, out > -1)
})
