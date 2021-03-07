testthat::skip_if_offline()
test_that("nzffd_add works", {
  ad1 <- nzffd_add(nzffd_data)
  expect_match(paste(colnames(ad1), collapse = " "), "GEOLOGY")
  expect_match(paste(colnames(ad1), collapse = " "), "SPRING")
  expect_match(paste(colnames(ad1), collapse = " "), "ORDER")
  expect_match(paste(colnames(ad1), collapse = " "), "VLY_LNDFRM")
  })


