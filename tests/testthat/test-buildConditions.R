context("buildCondition")


test_that("== operator", {
  out <- buildCondition("city", "==", "Seville" )
  expect_equal(out, "\"city\":\"Seville\"")
})

test_that("!= operator", {
  out <- buildCondition("city", "!=", "Seville" )
  expect_equal(out, "\"city\":{\"$not\":{\"$eq\":\"Seville\"}}")
})

