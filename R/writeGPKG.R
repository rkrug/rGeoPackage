#' Write GeoPackage
#'
#' Write Spatial data from GeoPackage format, via \code{\link[rgdal]{writeOGR}}.
#' TODO fix names of data row.names ("." issue)
#'
#' @param x spatial object of class TODO
#' @param file geopackage file name
#' @param layer name which should be used as the layer name in the GeoPackage. Defaults to class of the \code{x}.
#' @param verbose report on layers available when not specified, defaults to TRUE
#' @param ... arguments passed to \code{\link[rgdal]{writeOGR}}
#'
#' @export
#'
#' @examples
#' TODO
#' @importFrom rgdal writeOGR
writeGPKG <- function(
  x,
  file,
  layer,
  verbose = TRUE,
  ...
  ) {
  if (missing(layer)) {
    layer <- as.character(class(x))
  }
  rgdal::writeOGR(
    obj = x,
    dsn = file,
    layer = layer,
    verbose = verbose,
    driver = "GPKG",
    ...
    )
}
