library(rgdal)

# simple example, from vignette("sp"):
Sr1 = Polygon(cbind(c(2,4,4,1,2),c(2,3,5,4,2)))
Sr2 = Polygon(cbind(c(5,4,2,5),c(2,3,2,2)))
Sr3 = Polygon(cbind(c(4,4,5,10,4),c(5,3,2,5,5)))
Sr4 = Polygon(cbind(c(5,6,6,5,5),c(4,4,3,3,4)), hole = TRUE)

Srs1 = Polygons(list(Sr1), "s1")
Srs2 = Polygons(list(Sr2), "s2")
Srs3 = Polygons(list(Sr3, Sr4), "s3/4")
SpP = SpatialPolygons(list(Srs1,Srs2,Srs3), 1:3)

polylayer <- SpatialPolygonsDataFrame(SpP, data.frame(poly = 1:3, name = c("poly", "mc", "polygonface") ), match.ID = FALSE)
linelayer <- as(polylayer, "SpatialLinesDataFrame")
linelayer$name <- c("liney", "mc", "lineface")
pointlayer <- as(linelayer, "SpatialPointsDataFrame")
pointlayer$name <- make.names(rep(c("pointy", "mc", "pointface"), length = nrow(pointlayer)), unique = TRUE)

mpointlayer <- as(linelayer, "SpatialMultiPointsDataFrame")
#plot(mpointlayer, col = rainbow(5), cex = 3:1, pch = 19)

writeOGR(polylayer, dsn = "inst/extdata/file_poly.gpkg", layer = "polylayer", driver = "GPKG")
writeOGR(linelayer, dsn = "inst/extdata/file_line.gpkg", layer = "linelayer", driver = "GPKG")
## fails, why? - because of "." characters in the row.names
row.names(pointlayer) <- gsub("\\.", "_", row.names(pointlayer))
writeOGR(pointlayer, dsn = "inst/extdata/file_point.gpkg", layer = "pointlayer", driver = "GPKG")
writeOGR(mpointlayer, dsn = "inst/extdata/file_mpoint.gpkg", layer = "mpointlayer", driver = "GPKG")
