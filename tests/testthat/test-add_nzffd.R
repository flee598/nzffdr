test_that("add_nzffd works", {
  ad1 <- add_nzffd(nzffd_data)
    expect_match(paste(colnames(ad1), collapse = " "), "GEOLOGY")
    expect_match(paste(colnames(ad1), collapse = " "), "SPRING")
    expect_match(paste(colnames(ad1), collapse = " "), "ORDER")
    expect_match(paste(colnames(ad1), collapse = " "), "VLY_LNDFRM")
  })


