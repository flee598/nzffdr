test_that("nzffd_fill works", {
  fd1 <- nzffd_fill(nzffd_data, alt = FALSE)
  expect_match(paste(colnames(fd1), collapse = " "), "common_name")
  expect_match(paste(colnames(fd1), collapse = " "), "sci_name")
  expect_match(paste(colnames(fd1), collapse = " "), "threat_class")
  expect_match(paste(colnames(fd1), collapse = " "), "family")
  })





