test_that("fill_nzffd works", {
  fd1 <- fill_nzffd(nzffd_data)
  expect_match(paste(colnames(fd1), collapse = " "), "common_name")
  expect_match(paste(colnames(fd1), collapse = " "), "sci_name")
  expect_match(paste(colnames(fd1), collapse = " "), "threat_class")
  expect_match(paste(colnames(fd1), collapse = " "), "family")
  })





