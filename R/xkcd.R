#' @title Retrieve metadata about an xkcd comic
#'
#' @description
#' Given an xkcd comic number, this function retrieves a JSON object describing that comic from the official xkcd API.
#'
#' @importFrom jsonlite read_json
#' @export
#'
#'
#'
xkcd <- function(number) {
  url <- file.path("https://xkcd.com", number, "info.0.json")
  results <- jsonlite::read_json(url)
  return(results)
}


#' Visualize xkcd comics
#'
#' Given an [`xkcd`] object, this [`base::plot`] method retrieves the image file associated with
#' this comic from the xkcd website and displays it in the currently active graphics device.
#'
#' @param x an [`xkcd`] object
#' @param ... currently ignored
#'
#' @examples
#' \dontrun{
#' first_comic <- xkcd(1)
#' plot(first_comic)
#' }
#' @importFrom tools file_ext
#' @importFrom httr GET
#' @importFrom png readPNG
#' @importFrom jpeg readJPEG
#' @importFrom graphics plot.new
#' @importFrom grid grid.raster
#'
#' @exportS3Method
plot.xkcd <- function(x, ...) {

  img_type <- tools::file_ext(x$img)

  tmp <- httr::GET(url = x$img)

  if (img_type == "png") {
    p <- png::readPNG(tmp$content)
  } else if (img_type == "jpg" || img_type == "jpeg") {
    p <- jpeg::readJPEG(tmp$content)
  }

  graphics::plot.new()
  grid::grid.raster(p)
}
