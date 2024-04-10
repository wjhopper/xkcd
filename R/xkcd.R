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
  x <- new_xkcd(results)
  x <- validate_xkcd(x)
  return(x)

}

new_xkcd <-function(x) {

  stopifnot(is.list(x))

  structure(x,
            class = "xkcd"
            )
}

validate_xkcd <- function(x) {

  required_fields <- c("month", "num", "link", "year", "news", "safe_title",
                       "transcript", "alt", "img", "title", "day"
                       )

  if (!all(required_fields %in% names(x))) {
    difference <- setdiff(required_fields, names(x))
    stop("xkcd object is missing the followin required fields: ",
         paste(difference, collapse = ", ")
         )
  }

  char_fields <- c("month", "link", "year", "news", "safe_title",
                   "transcript", "alt", "img", "title", "day"
                   )

  for (f in char_fields) {
    if (!(is.character(x[[f]]) && length(x[[f]]) == 1)) {
      stop("The ", f, " field in an xkcd object must be a character vector of length 1")
    }
  }

  if (!(is.numeric(x[["num"]]) && length(x[["num"]]) == 1)) {
    stop("The `num` field in an xkcd object must be a numeric vector of length 1")
  }

  return(x)
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
