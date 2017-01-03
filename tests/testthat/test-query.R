context("query")


# test_that("query species", {
#   cnx <- connect("http://www.traitbase.info", "demo", "1234")
#   resource <- resource(cnx, "species")
#   out <- query(resource)
#   expect_equal(TRUE, length(out) > -1)
#   expect_equal(7, ncol(out))
# })
#
# test_that("query species limit=1", {
#   cnx <- connect("http://www.traitbase.info", "demo", "1234")
#   resource <- resource(cnx, "species")
#   out <- query(resource, limit=1)
#   expect_equal(1, nrow(out))
#   expect_equal(7, ncol(out))
# })
#
# test_that("query species limit=2 skip=1", {
#   cnx <- connect("http://www.traitbase.info", "demo", "1234")
#   resource <- resource(cnx, "species")
#   out <- query(resource, limit=2, skip=1)
#   expect_equal(2, nrow(out))
#   expect_equal(7, ncol(out))
# })
#
# test_that("query species limit=1 names", {
#   cnx <- connect("http://www.traitbase.info", "demo", "1234")
#   resource <- resource(cnx, "species")
#   out <- query(resource, limit=1)
#   n <- names(out)
#   expect_equal("_id", n[[1]])
#   expect_equal("nombre", n[[2]])
#   expect_equal("telefono", n[[3]])
#   expect_equal("imagen", n[[4]])
#   expect_equal("localizacion.coordinates1", n[[5]])
#   expect_equal("localizacion.coordinates2", n[[6]])
#   expect_equal("localizacion.type", n[[7]])
# })
#
# test_that("query species limit=1 with condition", {
#   cnx <- connect("http://www.traitbase.info", "demo", "1234")
#   resource <- resource(cnx, "species")
#   out <- query(resource, limit=3, conditions=buildCondition("genus", "==", "Andrena" ))
#   expect_equal(1, nrow(out))
# })


