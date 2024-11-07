library(httr2)
library(terra)
library(rnaturalearth)

#aus <- ne_countries(country = "Australia", returnclass = "sv")
aus <-ozmaps::ozmap_states[8,]


user_agent <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:124.0) Gecko/20100101 Firefox/124.0"

req_cdd <- request("http://www.bom.gov.au/web01/ncc/www/climatology/degree-days/cdd18/cdd18an.zip")


req_user_agent(req_cdd, user_agent) |>
  req_perform(path = "cdd18an.zip")
unzip("cdd18an.zip")
cdd18ann <- rast("cdd18ann.txt")
cdd18ann <- mask(cdd18ann, aus)

req_hdd <- request("http://www.bom.gov.au/web01/ncc/www/climatology/degree-days/hdd18/hdd18an.zip")

req_user_agent(req_hdd, user_agent) |>
  req_perform(path = "hdd18an.zip")
unzip("hdd18an.zip")
hdd18ann <- rast("hdd18ann.txt")
hdd18ann <- mask(hdd18ann, aus)


par(mfrow = c(1, 2))

plot(cdd18ann, axes=FALSE)
contour(cdd18ann, levels=c(0,500,1000,2000,3000,4000),  add=TRUE)

plot(hdd18ann, breaks=c(0,500,1000,2000,3000,4000), axes=FALSE)
contour(hdd18ann, levels=c(0,500,1000,2000,3000,4000),  add=TRUE)
