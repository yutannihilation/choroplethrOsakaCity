#' A Choropleth Class for Osaka City Map
#'
#' @name osakaCityChoropleth
#'
#' @export
osakaCityChoropleth <- R6Class(
  "osakaCityChoropleth",
  inherit = choroplethr:::Choropleth,
  public = list(
    initialize = function(user.df)
    {
      data(osaka_city.map, package = "choroplethrOsakaCity")
      super$initialize(osaka_cify.map, user.df)
    }
  )
)

#' @rdname osakaCityChoropleth
#' @export
osaka_city_chropleth <- function(df, title = "", legend = "", num_colors = 7, zoom = NULL){
  c        <- osakaCityChoropleth$new(df)
  c$title  <- title
  c$legend <- legend
  c$set_num_colors(num_colors)
  c$set_zoom(zoom)
  c$render()
}
