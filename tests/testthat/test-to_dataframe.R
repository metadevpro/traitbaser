context("to_dataframe")

test_that("invalid mode should return null", {
  out <- to_dataframe(list(), keep_metadata="invalid-set")
  expect_equal(out, NULL)
})

test_that("keep_metadata=clean", {
  r1 = list("_id"="abcd1234", a="a1", b=12, c=FALSE, "_links" = list(a="b"));
  r2 = list("_id"="edcf1234", a="z1", b=34, c=TRUE, "_links" = list(c="d"));
  input = list(r1, r2)

  out <- to_dataframe(input, keep_metadata="clean")
  expect_equal(2, nrow(out))
  expect_equal(4, ncol(out))
  expect_equal("_id", names(out)[[1]])
  expect_equal("a", names(out)[[2]])
  expect_equal("b", names(out)[[3]])
  expect_equal("c", names(out)[[4]])
  
})

test_that("keep_metadata=raw", {
  r1 = list("_id"="abcd1234", a="a1", b=12, c=FALSE, "_links" = list(a="b"));
  r2 = list("_id"="edcf1234", a="z1", b=34, c=TRUE, "_links" = list(c="d"));
  input = list(r1, r2)
  
  out <- to_dataframe(input, keep_metadata="raw")
  expect_equal(2, nrow(out))
  expect_equal(4, ncol(out))
})

test_that("keep_metadata=raw_links", {
  r1 = list("_id"="abcd1234", a="a1", b=12, c=FALSE, "_links" = list(a="b"));
  r2 = list("_id"="edcf1234", a="z1", b=34, c=TRUE, "_links" = list(a="d"));
  input = list(r1, r2)
  
  out <- to_dataframe(input, keep_metadata="raw_links")
  expect_equal(2, nrow(out))
  expect_equal(5, ncol(out))
  expect_equal("_id", names(out)[[1]])
  expect_equal("a", names(out)[[2]])
  expect_equal("b", names(out)[[3]])
  expect_equal("c", names(out)[[4]])
  expect_equal("_links.a", names(out)[[5]])
})


