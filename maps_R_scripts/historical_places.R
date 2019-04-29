# José Luis Losada · Formation Textes et éditions numériques · Lausanne 2019

#---------------------------------#
###   Historical places names   ###
###     Historical maps         ###
#---------------------------------#

# To geolocate historical places and plot a map.

library(georeference)

# Run the georef function. Limit the search to Europe to improve the results.
places = georef(c("Roma", "Lutetia", "Helvetia", "Cularo"),  bbox = "-16.7,43.7,35.4,59.8")

# Plot the map with the tiles of the Roman Empire.

library(leaflet)

leaflet() %>%
addTiles(
    urlTemplate = "http://pelagios.org/tilesets/imperium/{z}/{x}/{y}.png", 
    attribution = 'Barrington Roman Empire: (CC BY-SA) <a href="http://dare.ht.lu.se">DARE</a> & <a href="http://commons.pelagios.org">Pelagios</a>',
    group="Roman Empire",
    option=list(continuousWorld=TRUE, tileSize="256")) %>%
  
    addProviderTiles ("CartoDB.Positron", group = "Modern") %>%    
  
    addMarkers(places$lon, places$lat, label=places$searched_name) %>%
    
# Add the menu layers
    
addLayersControl(
    baseGroups = c("Modern","Roman Empire"),
    options = layersControlOptions(collapsed = F))