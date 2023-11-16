#' Metadata for all xkcd comics (so far)
#'
#' @format A data frame with 2850 rows and 12 columns:
#' \describe{
#'   \item{num}{Comic number}
#'   \item{year}{Year comic was published}
#'   \item{month}{Month comic was published}
#'   \item{day}{Day of month comic was published}
#'   \item{link}{Link to relevant context, source information, or large version of the comic}
#'   \item{news}{Seemingly random information about the comic (backstory, contributors, merchandise. May contain raw HTML.}
#'   \item{title}{Title of the comic}
#'   \item{safe_title}{Year}
#'   \item{transcript}{Transcription of the text in the comic}
#'   \item{alt}{alt text for image in web browsers}
#'   \item{img}{URL for the comic image}
#'   ...
#' }
#' @source <https://xkcd.com/json.html>
"xkcd_data"
