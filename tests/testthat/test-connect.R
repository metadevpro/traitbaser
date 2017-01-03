context("connect")

test_that("connect should work", {
  out <- connect("http://www.traitbase.info", "demo", "1234")
  expect_equal(TRUE, is.list(out))
  expect_equal("http://www.traitbase.info", out[[1]])
  expect_equal("demo", out[[2]])
  expect_equal("1234", out[[3]])
  expect_equal(200, out[[4]]$status)
})

test_that("connect should fail: due to unexisting URL", {
  expect_error(connect("http://api.acme.com", "demo", "1234"))
})

test_that("connect should fail due to invalid credentials", {
  expect_error(connect("http://www.traitbase.info", "noUser", "noPassword"))
})
