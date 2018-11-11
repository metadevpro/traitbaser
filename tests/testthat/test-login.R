context("login")
skip_on_cran()
skip_if_no_auth()
# store login
ologin <- get_login()

test_that("tests forget_login", {
  forget_login()
  expect_equal(Sys.getenv("TRAITBASE_USER"), "")
  expect_equal(Sys.getenv("TRAITBASE_PWD"), "")
})

test_that("tests set_login", {
  res <- set_login("tb", "1234")
  expect_equal(Sys.getenv("TRAITBASE_USER"), res[1])
  expect_equal(Sys.getenv("TRAITBASE_PWD"), res[2])
})

test_that("tests get_login", {
  res <- get_login()
  expect_equal(Sys.getenv("TRAITBASE_USER"), res[1])
  expect_equal(Sys.getenv("TRAITBASE_PWD"), res[2])
})

# restore login
set_login(ologin[1], ologin[2])
