context("auxiliar")

test_that("tests protectCommas", {
  # protectCommas does nothing if no comma: abc
  expect_equal(protectCommas("abc"), "abc")
  # does nothing if no comma: 12.3
  expect_equal(protectCommas("12.3"), "12.3")
  # escapes if comma found: a,b
  expect_equal(protectCommas("a,b"), "\"a,b\"")
  # escapes if comma found: ,bc
  expect_equal(protectCommas(",bc"), "\",bc\"")
  # escapes if comma found: az,
  expect_equal(protectCommas("az,"), "\"az,\"")
  # escapes if quote found: a\"z
  expect_equal(protectCommas("a\"z"), "\"a\"\"z\"")
})


test_that("tets quote4csv", {
  # string (NB here actually protectCommas is tested again, so some test couls be dropped)
  expect_equal(quote4csv("a,b"), "\"a,b\"")
  expect_equal(quote4csv("ab"), "ab")
  expect_equal(quote4csv("a\"b"), "\"a\"\"b\"")
  # test booleans
  expect_equal(quote4csv(TRUE), "true")
  # test numeric
  expect_equal(quote4csv(-14.56), "-14.56")
  expect_equal(quote4csv(2+2i), "2+2i")
})


test_that("df2csv works", {
  df <- utils::read.csv(text="\"a\",\"b\",\"c\",\"d\"\r\n1,a b,-2.3,\"a, b\"\" and c\"")
  out <- df2csv(df)
  expect_equal(out, "\"a\",\"b\",\"c\",\"d\"\n1,\"a b\",-2.3,\"a, b\"\" and c\"")
})
