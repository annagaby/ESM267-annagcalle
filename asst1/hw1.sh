# Assignment 1: Satellite data subsetting
# Anna Calle
# 10/21/19

# See the commands as they are executed
set -x

# Create ouput folder
mkdir -p output

# Set variables
counties="tl_2018_us_county/tl_2018_us_county.shp"
modis="crefl2_A2019257204722-2019257205812_250m_ca-south-000_143.tif"

# Use ogrinfo to find out the counties shapefile attribute names
ogrinfo -al -so $counties

# Use ogr2ogr to re-project to NAD83
ogr2ogr -t_srs EPSG:3310 output/projected.shp $counties

# Use ogr2ogr to extract SB outline
ogr2ogr -where "name='Santa Barbara'" output/sb_county.shp output/projected.shp

# Use gdalwarp to clip MODIS image to SB county outline
 gdalwarp -dstalpha -cutline output/sb_county.shp -crop_to_cutline $modis output/modis_sb.tif

# Use gdalwarp to re-project to NAD83
gdalwarp -dstalpha -t_srs EPSG:3310 output/modis_sb.tif output/modis_sb_projected.tif


















