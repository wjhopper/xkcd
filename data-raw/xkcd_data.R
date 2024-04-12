## code to prepare `xkcd_data` dataset goes here

library(jsonlite)

json_objects <- vector(mode = "list", 10)

for (i in 1:10) {
  url <- file.path("https://xkcd.com", i, "info.0.json")
  json_objects[[i]] <- jsonlite::read_json(url)
  Sys.sleep(1)
}

xkcd <- do.call(rbind, json_objects)
xkcd_data <- as.data.frame(xkcd)

usethis::use_data(xkcd_data, overwrite = TRUE)
