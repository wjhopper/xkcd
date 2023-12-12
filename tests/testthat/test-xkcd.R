test_that("xkcd objects have 11 elements", {
  expect_equal(length(xkcd(3)), 11)
})

test_that("xkcd objects are lists", {
  expect_true(is.list(xkcd(3)))
})

test_that("xkcd objects have class xkcd", {
  expect_equal(class(xkcd(3)), "xkcd")
})

library(vdiffr)

test_that("xkcd objects have class xkcd", {
  vdiffr::expect_doppelganger(
    title = "xkcd 3",
    fig = plot(xkcd(3))
  )
 }
)

test_that("API key can be retrieved", {
  if (Sys.getenv("GITHUB_ACTIONS") == "true") {
    api_key <- Sys.getenv("API_KEY")
  } else {
    api_key <- readLines("API_KEY.txt")
  }
  expect_equal(api_key, "hello!")
})

