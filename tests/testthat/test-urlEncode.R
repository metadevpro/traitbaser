context("urlEncode")

test_that("NULL should return 'null'", {
  out <- urlEncode(NULL)
  expect_equal(out, "null")
})

test_that("5 should return 5", {
  out <- urlEncode(5)
  expect_equal(out, 5)
})

test_that("A should return \"A\"", {
  out <- urlEncode("A")
  expect_equal(out, "\"A\"")
})

test_that("TRUE should return true", {
  out <- urlEncode(TRUE)
  expect_equal(out, "true")
})

test_that("FALSE should return false", {
  out <- urlEncode(FALSE)
  expect_equal(out, "false")
})

test_that("complex number should return itself", {
  input <- 2i+1
  out <- urlEncode(input)
  expect_equal(out, input)
})

