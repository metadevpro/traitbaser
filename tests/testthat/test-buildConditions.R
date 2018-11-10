context("buildCondition")

test_that("tests `==` operator", {
  out <- buildCondition("city", "==", "Seville" )
  expect_equal(out, "\"city\":\"Seville\"")
})

test_that("testa the `!=` operator", {
  out <- buildCondition("city", "!=", "Seville" )
  expect_equal(out, "\"city\":{\"$not\":{\"$eq\":\"Seville\"}}")
})

test_that("tests other operators", {
  expect_error(buildCondition("city", "<=", "Seville" ), "'arg' should be one of “!=”, “==”")
})
