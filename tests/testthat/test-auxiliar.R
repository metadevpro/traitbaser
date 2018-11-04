context("auxiliar")

test_that("protectCommas do nothing if no comma: abc", {
  out <- protectCommas("abc")
  expect_equal(out, "abc")
})
test_that("protectCommas do nothing if no comma: 12.3", {
  out <- protectCommas("12.3")
  expect_equal(out, "12.3")
})
test_that("protectCommas escapes if comma found: a,b", {
  out <- protectCommas("a,b")
  expect_equal(out, "\"a,b\"")
})
test_that("protectCommas escapes if comma found: ,bc", {
  out <- protectCommas(",bc")
  expect_equal(out, "\",bc\"")
})
test_that("protectCommas escapes if comma found: az,", {
  out <- protectCommas("az,")
  expect_equal(out, "\"az,\"")
})
test_that("protectCommas escapes if quote found: a\"z", {
  out <- protectCommas("a\"z")
  expect_equal(out, "\"a\"\"z\"")
})
test_that("quote4csv works on strings: a,b", {
  out <- quote4csv("a,b")
  expect_equal(out, "\"a,b\"")
})
test_that("quote4csv works on strings: ab", {
  out <- quote4csv("ab")
  expect_equal(out, "ab")
})
test_that("quote4csv works on strings: a\"b", {
  out <- quote4csv("a\"b")
  expect_equal(out, "\"a\"\"b\"")
})





test_that("quote4csv works on booleans: TRUE", {
  out <- quote4csv(TRUE)
  expect_equal(out, "true")
})
test_that("quote4csv works on booleans: FALSE", {
  out <- quote4csv(FALSE)
  expect_equal(out, "false")
})
test_that("quote4csv works on numbers: 0", {
  out <- quote4csv(0)
  expect_equal(out, "0")
})
test_that("quote4csv works on numbers: -14", {
  out <- quote4csv(-14)
  expect_equal(out, "-14")
})
test_that("quote4csv works on numbers: -14.56", {
  out <- quote4csv(-14.56)
  expect_equal(out, "-14.56")
})

test_that("df2csv works", {
  df <- read.csv(text="\"a\",\"b\",\"c\",\"d\"\r\n1,a b,-2.3,\"a, b\"\" and c\"")
  out <- df2csv(df)
  expect_equal(out, "\"a\",\"b\",\"c\",\"d\"\n1,\"a b\",-2.3,\"a, b\"\" and c\"")
})




urlEncode(123)
