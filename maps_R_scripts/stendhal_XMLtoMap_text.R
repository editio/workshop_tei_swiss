# José Luis Losada · Formation Textes et éditions numériques · Lausanne 2019

#---------------------------------#
### FROM THE TEI/XML TO THE MAP ###
#---------------------------------#

# To extract the places, look up the coordinates, plot a map.

library(XML)

# Load the XML
xmlfile <-  xmlParse("03_TEI-EntitesNommees/3.4-Stendhal_Memoires_1838_done.xml", encoding="UTF-8")
namespace <- c(TEI="http://www.tei-c.org/ns/1.0")

# Extract the placeNames
placesNames <-  sapply(getNodeSet(xmlfile, "//TEI:text//TEI:placeName", namespace), xmlValue)

# Put them in a dataframe counting its frequency 
places = as.data.frame(table(placesNames), stringsAsFactors = F)

# georeference the places
# install.packages("devtools")
# library(devtools)
# install_github("editio/georeference")
# see at https://github.com/editio/georeference
library(georeference)

# GeoNames requires a user account, free, to use their API services.

places_geo = georef(places$places, source = "geonames", inject = "username=yourusername")

# Pelagios (several gazzetters)
# places_geo = georef(places$places)

# Plot the map without frequency

library(leaflet)

leaflet() %>%
  addTiles() %>%
  addMarkers(places_geo$lon, places_geo$lat, label=places_geo$name)


# Plot the map with frequency and add a legend

leaflet() %>%
  addTiles() %>%
  addCircleMarkers(places_geo$lon, places_geo$lat, label=places_geo$searched_name, weight = 6, fillOpacity=0.7, radius = sqrt(places$Freq)*10) %>%
  addControl("EXERCISE 03 · Named entities: </br> Places mencioned in Stendhal's <em>Mémoires d'un touriste</em> (excerpt)", position = "bottomleft" )
