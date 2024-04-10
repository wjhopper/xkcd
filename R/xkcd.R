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
