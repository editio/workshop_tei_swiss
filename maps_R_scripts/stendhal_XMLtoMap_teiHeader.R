# José Luis Losada · Formation Textes et éditions numériques · Lausanne 2019

#---------------------------------#
### FROM THE TEI/XML TO THE MAP ###
#---------------------------------#

# To extract the places and coordinates (teiHeader), plot a map.

library(XML)

# Load the XML
xmlfile <-  xmlParse("03_TEI-EntitesNommees/3.4-Stendhal_Memoires_1838_done.xml", encoding="UTF-8")
namespace <- c(TEI="http://www.tei-c.org/ns/1.0")

# Extract with xPath from teiHeader
coords <-  sapply(getNodeSet(xmlfile, "//TEI:geo", namespace), xmlValue)

# Extract with xPath from teiHeader
places <-  sapply(getNodeSet(xmlfile, "//TEI:teiHeader//TEI:placeName", namespace), xmlValue)

# Put them in a data table
coords = as.data.frame(coords)
places = as.data.frame(places)
placesGeo = cbind(coords, places)

library(tidyverse)

# Divide coord cell
placesGeo = separate(placesGeo, coords, c("lat","lon"), sep=",")

placesGeo$lat = as.numeric(placesGeo$lat)
placesGeo$lon = as.numeric(placesGeo$lon)

# Plot the map
library(leaflet)

leaflet() %>%
  addTiles() %>%
  addMarkers(placesGeo$lon, placesGeo$lat, label = placesGeo$places)
