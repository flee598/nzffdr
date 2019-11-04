test_that("clean_nzffd works", {
  cd1 <- clean_nzffd(fishd = nzffd_data)
  expect_equal(c(200,23), dim(cd1))
})

