#' Read GeoPackage
#'
#' Read Spatial data from GeoPackage format, via \code{\link[rgdal]{readOGR}}.
#' @param x geopackage file name
#' @param y layer name, if not specified the first layer found will be read
#' @param verbose report on layers available when not specified, defaults to TRUE
#' @param ... arguments passed to \code{\link[rgdal]{readOGR}}
#'
#' @return Spatial object as per \code{\link[rgdal]{readOGR}}
#' @export
#'
#' @examples
#' f <- system.file("extdata", "file_poly.gpkg", package= "rGeoPackage")
#' x <- geopackage(f)
#' @importFrom rgdal ogrListLayers readOGR
geopackage <- function(x, y, verbose = TRUE, ...) {
  if (is.character(x)) {
    layers <- rgdal::ogrListLayers(x)
    if (missing(y)) {
      y <- layers[1L]

      if (verbose) {
        message(sprintf("found %i layers in %s:", length(layers), x))
        message(paste(layers, collapse = ", "))
        message("\n")
        message(sprintf("reading first layer:  %s", y))
      }
    } else {
      if (!any(grepl(y, layers))) stop(sprintf("layer not found: %s", y))
    }
  }
  rgdal::readOGR(x, y, verbose = verbose, ...)
}
