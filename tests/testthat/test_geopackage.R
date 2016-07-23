stopifnot(require(rGeoPackage))
stopifnot(require(sp))


# Create sample data as in files.R ----------------------------------------
# code from file.R which creates some layers

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

# read the data which comes with the package ------------------------------

print("")
print("")
print( "-------------- line --------------")
f_line   <- system.file("extdata", "file_line.gpkg",   package= "rGeoPackage")
x_line   <- geopackage(f_line,   verbose=TRUE)
print( all.equal(x_line,   linelayer) )


print("")
print("")
print( "-------------- point --------------")
f_point  <- system.file("extdata", "file_point.gpkg",  package= "rGeoPackage")
x_point  <- geopackage(f_point,  verbose=TRUE)
print( all.equal(x_point,  pointlayer) )

print("")
print("")
print( "-------------- poly --------------")
f_poly   <- system.file("extdata", "file_poly.gpkg",   package= "rGeoPackage")
x_poly   <- geopackage(f_poly,  verbose=TRUE)
print( all.equal(x_poly,  polylayer) )

print("")
print("")
print( "-------------- mpoint --------------")
f_mpoint <- system.file("extdata", "file_mpoint.gpkg", package= "rGeoPackage")
x_mpoint <- geopackage(f_mpoint, verbose=TRUE)
print( all.equal(x_mpoint, mpointlayer) )
