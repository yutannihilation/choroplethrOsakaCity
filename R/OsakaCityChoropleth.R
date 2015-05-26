#' A Choropleth Class for Osaka City Map
#'
#' @name osakaCityChoropleth
#' @importFrom ggplot2 geom_text
#' @export
osakaCityChoropleth <- R6Class(
  "osakaCityChoropleth",
  inherit = choroplethr:::Choropleth,
  public = list(
    show_labels = TRUE,

    initialize = function(user.df)
    {
      data(osaka_city.map, package = "choroplethrOsakaCity")
      super$initialize(osaka_cify.map, user.df)
    },

    render = function()
    {
      choropleth = super$render()

      # by default, add labels for the lower 48 states
      if (self$show_labels) {
        data(osaka_city.label, package = "choroplethrOsakaCity")

        choropleth = choropleth +
          geom_text(data = osaka_city.label, aes(long, lat, label = region_name, group = NULL), colour = 'black')
      }

      choropleth
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
