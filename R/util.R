#' Convert ward code from/to ward name
#'
#' @name osaka_city.code
#' @importFrom stringr str_replace_all
#' @export
to_osaka_ward_name <- function(ward_code, to = c("kanji", "alphabet")) {
  to <- match.arg(to)

  data(osaka_city.code, package = "choroplethrOsakaCity")
  match_idx <- match(as.character(ward_code), osaka_city.code[, "code"])
  osaka_city.code[match_idx, to]
}

#' @rdname osaka_city.code
#'
#' @export
to_osaka_ward_code <- function(ward_name, from = c("kanji", "alphabet")) {
  from <- match.arg(from)

  if(from == "kanji") {
    # add 区 suffix if no 区
    ward_name_ <- str_replace_all(ward_name, "([^区])$", "\\1区")

    matchee    <- osaka_city.code[, from]
  } else if(from == "alphabet") {
    # convert to plain ASCII characters
    # add -ku suffix if no -ku
    ward_name_ <- iconv(ward_name, "UTF-8", "ASCII//TRANSLIT")
    ward_name_ <- str_replace_all(ward_name_, "([^(?!\\-ku)])$", "\\1-ku")

    matchee    <- iconv(osaka_city.code[, from], "UTF-8", "ASCII//TRANSLIT")
  } else {
    stop('`from` must be "kanji" or "alphabet"')
  }

  data(osaka_city.code, package = "choroplethrOsakaCity")
  match_idx <- match(ward_name_, matchee)
  osaka_city.code[match_idx, "code"]
}
