test_that("xkcd objects have the correct structure", {
  # xkcd objects should have 11 elements
  expect_equal(length(xkcd(3)), 11)
  # xkcd objects should be built on top of lists
  expect_true(is.list(xkcd(3)))
  # xkcd objects should have class xkcd
  expect_equal(class(xkcd(3)), "xkcd")
})

library(vdiffr)

test_that("plotting xkcd objects works", {
  vdiffr::expect_doppelganger(
    title = "xkcd comic number 3",
    fig = plot(xkcd(3))
  )
})
