context("importDataset")

# test_that("importDataset Error should fail with errors", {
  # cnx <- connect("http://www.traitbase.info")
  # txt <- readLines("data-error.csv")
  # out <- importDataset(cnx, txt)
  # ##
  # expect_equal(TRUE, is.list(out))
  # expect_equal(FALSE, out$valid)
  # expect_equal(FALSE, out$imported)
  # expect_equal(4, length(out$errors))
  # expect_equal(201, out$errors[[1L]]$code)
  # expect_equal(202, out$errors[[2L]]$code)
  # expect_equal(401, out$errors[[3L]]$code)
  # expect_equal(401, out$errors[[4L]]$code)
  # expect_equal("Invalid year specified: 5000 at line 3", out$errors[[1]]$message)
  # expect_equal("Invalid month specified: 16 at line 5", out$errors[[2]]$message)
  # expect_equal("Unreconized or ambiguous species: 'Andrena sp'. Nearest registered in ITIS is: 'Andrena specularia' at line 2",
  #               out$errors[[3]]$message)
  # expect_equal("Unreconized or ambiguous species: 'Bombus sp'. Nearest registered in ITIS is: 'Bombus sporadicus' at line 4",
  #               out$errors[[4]]$message)
# })
