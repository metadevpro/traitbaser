context("buildQueryConditions")


test_that("test null returns NA", {
  out <- buildQueryConditions(NULL)
  expect_equal(out, NA)
})

test_that("test a returns a", {
  out <- buildQueryConditions("a" )
  expect_equal(out, "conditions={a}")
})

test_that("test (a, b) returns a,b", {
  out <- buildQueryConditions(list("a", "b"))
  expect_equal(out, "conditions={a,b}")
})