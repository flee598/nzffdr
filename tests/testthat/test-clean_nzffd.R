test_that("nzffd_clean works", {
  cd1 <- nzffd_clean(fishd = nzffd_data)
  expect_equal(c(200,23), dim(cd1))
})

