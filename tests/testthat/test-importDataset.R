context("importDataset")

test_that("importDataset Error should fail with errors", {
  cnx <- connect("http://www.traitbase.info", "demo", "1234")
  txt <- readLines("data-error.csv")
  out <- importDataset(cnx, txt)

  expect_equal(TRUE, is.list(out))
  expect_equal(FALSE, out$valid)
  expect_equal(FALSE, out$imported)
  expect_equal(10, length(out$errors))
  expect_equal(201, out$errors[[1]]$code)
  expect_equal(202, out$errors[[2]]$code)
  expect_equal(601, out$errors[[3]]$code)
  expect_equal(601, out$errors[[4]]$code)
  expect_equal("Invalid year specified: 5000 at line 3", out$errors[[1]]$message)
  expect_equal("Invalid month specified: 16 at line 5", out$errors[[2]]$message)
  expect_equal("Trait name: 'sex' not defined for species: 'Andrena sp' at line 2",
                out$errors[[3]]$message)
  expect_equal("Trait name: 'sex' not defined for species: 'Andrena barbilabris' at line 3",
                out$errors[[4]]$message)
})

