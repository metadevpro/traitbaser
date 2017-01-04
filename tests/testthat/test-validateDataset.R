context("validateDataset")

test_that("validateImport OK should work", {
  cnx <- connect("http://www.traitbase.info", "demo", "1234")
  txt <- readLines("data-ok.csv")
  out <- validateDataset(cnx, txt)

  expect_equal(TRUE, is.list(out))
  expect_equal(TRUE, out$valid)
  expect_equal(FALSE, out$imported)
  expect_equal(0, length(out$errors))
})

test_that("validateImport Error should fail with errors", {
  cnx <- connect("http://www.traitbase.info", "demo", "1234")
  txt <- readLines("data-error.csv")
  out <- validateDataset(cnx, txt)

  expect_equal(TRUE, is.list(out))
  expect_equal(FALSE, out$valid)
  expect_equal(FALSE, out$imported)
  expect_equal(4, length(out$errors))
  expect_equal(201, out$errors[[1]]$code)
  expect_equal(202, out$errors[[2]]$code)
  expect_equal(401, out$errors[[3]]$code)
  expect_equal(401, out$errors[[4]]$code)
  expect_equal("Invalid year specied: 5000 at line 3", out$errors[[1]]$message)
  expect_equal("Invalid month specied: 16 at line 5", out$errors[[2]]$message)
  expect_equal("Unreconized or ambiguous species: 'Andrena sp'. Nearest registered in ITIS is: 'Andrena specularia' at line 2",
                out$errors[[3]]$message)
  expect_equal("Unreconized or ambiguous species: 'Bombus sp'. Nearest registered in ITIS is: 'Bombus sporadicus' at line 4",
                out$errors[[4]]$message)
})

