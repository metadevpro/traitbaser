context("to_dataframe")

test_that("for empty list toDataframe returns NULL", {
  out <- toDataframe(list())
  expect_equal(out, NULL)
})

test_that("test toDataframe", {
  r1 <- list("_id"="abcd1234", a="a1", b = 12, c = FALSE, "_links" = list(a="b"))
  r2 <-  list("_id"="edcf1234", a="z1", b = 34, c = TRUE, "_links" = list(c="d"))
  out <- toDataframe(list(r1, r2))
  expect_true(all(dim(out) == c(2, 4)))
  expect_true(all(names(out) == names(r1)[1:4]))
  expect_true(all(out[1,] ==  unlist(r1[1:4])))
})

test_that("test addNames", {
  r3 <- addNames(r1, c("_id", "a", "b", "c", "d", "_links"))
  expect_true("d" %in% names(r3))
  expect_true(is.na(r3$d))
})
