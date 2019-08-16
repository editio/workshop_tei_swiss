# José Luis Losada · Formation Textes et éditions numériques · Lausanne 2019

#---------------------------------#
###   Historical places names   ###
###     Historical maps         ###
#---------------------------------#

# To geolocate historical places and plot a map.

# georeference the places
# install.packages("devtools")
# library(devtools)
# install_github("editio/georeference")
# see at https://github.com/editio/georeference

library(georeference)

# Run the georef function. Limit the search to Europe to improve the results.
places = georef(c("Roma", "Lutetia", "Helvetia", "Cularo"),  bbox = "-16.7,43.7,35.4,59.8")

# Plot the map with the tiles of the Roman Empire.

library(leaflet)

leaflet() %>%
addTiles(
    urlTemplate = "https://dare.ht.lu.se/tiles/imperium/{z}/{x}/{y}.png", 
    attribution = 'Barrington Roman Empire: (CC BY-SA) <a href="http://dare.ht.lu.se">DARE</a>',
    group="Roman Empire",
    option=list(continuousWorld=TRUE, tileSize="256")) %>%
  
    addProviderTiles ("CartoDB.Positron", group = "Modern") %>%    
  
    addMarkers(places$lon, places$lat, label=places$searched_name) %>%
    
# Add the menu layers
    
addLayersControl(
    baseGroups = c("Modern","Roman Empire"),
    options = layersControlOptions(collapsed = F))
