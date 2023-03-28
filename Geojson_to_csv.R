library(jsonlite)
library(tidyverse)

json_data_raw<-fromJSON("C:\\Users\\owner\\Documents\\Web_Map\\Personal_Bivariate\\assets\\point_Pop_Zip.geojson")

latlong <- c()

n = 1
for(i in seq(1,808,1)){
abc <- data.frame(ZIP = json_data_raw$features[n][[1]]$properties$ZCTA5CE10,
                  lat = (json_data_raw$features[n][[1]]$geometry$coordinates[2]),
                  long = (json_data_raw$features[n][[1]]$geometry$coordinates[1]),
                  stringsAsFactors = FALSE)
n =n+1
latlong <- rbind(abc, latlong)
}

setwd("~/GRAM/Gasparini/On_My_Own/Files")
fwrite(latlong, "latlong.csv")

#==============================================================================#
# Selecting city locations
#==============================================================================#

data <- fread("C:\\Users\\owner\\Documents\\GRAM\\Gasparini\\On_My_Own\\Files\\Cities\\North_Carolina_sheps_temp.csv")
cityinfo <- fread("C:\\Users\\owner\\Documents\\GRAM\\Gasparini\\On_My_Own\\Files\\Cities\\NC_Cities.csv")
cities <- c(28806, 28601, 28202, 27609, 27834, 28403)
Region <- c(2,1,2,1,3,3)

City_latlong <- latlong %>%
  filter(ZIP %in% cities) 

City_latlong <- cbind(cityinfo$city, City_latlong) %>%
  rename(city = "cityinfo$city")

City_latlong <- cbind(City_latlong, Region)

setwd("~/GRAM/Gasparini/On_My_Own/Files/Cities")
fwrite(City_latlong, "city_latlong.csv")
