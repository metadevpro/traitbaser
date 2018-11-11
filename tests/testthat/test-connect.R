context("connect")
skip_on_cran()
skip_if_no_auth()

test_that("connect should work", {
  out <- connect("http://www.traitbase.info")
  expect_equal(TRUE, is.list(out))
  expect_equal("http://www.traitbase.info", out[[1]])
  expect_equal(200, out[[4]]$status)
})

test_that("connect should fail: due to unexisting URL", {
  expect_error(connect("http://api.acme.com"))
})

test_that("connect should fail due to invalid credentials", {
  expect_error(connect("http://www.traitbase.info", "noUser", "noPassword"))
})
