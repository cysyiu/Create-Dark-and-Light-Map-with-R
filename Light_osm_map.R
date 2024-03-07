#Import Library
library(tidyverse)
library(osmdata)
library(sf)
library(showtext)

#Get data from OSM
streets <- getbb("Tsim Sha Tsui")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "primary", 
                            "secondary", "tertiary")) %>%
  osmdata_sf()


small_streets <- getbb("Tsim Sha Tsui")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street",
                            #"unclassified",
                            "service", "footway")) %>%
  osmdata_sf()



background_color<-'#1E212B'
street_color<-'#FAD399'
small_street_color<-'#D4B483'
font_color<-'#FFFFFF'

#Import Font
font_add_google("Quattrocento", "Quattrocento")

#Plot Light Map
background_color2<-'#faf9ed'
street_color2<-'#13130c'
small_street_color2<-'#37261a'
font_color2<-'#13130c'

blr_light<-ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = street_color2,
          linewidth = .4,
          alpha = .8) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = small_street_color2,
          linewidth = .2,
          alpha = .6) +


  theme_void() +
  theme(plot.title = element_text( family = 'Quattrocento',
                                  color=font_color2,
                                  size = 18, face="bold", hjust=0.5),
        panel.border = element_rect(colour = font_color2, fill=NA, size=3),
        plot.margin=unit(c(0.6,1.6,1,1.6),"cm"),
        plot.subtitle = element_text(color=font_color2,
                                     family = 'Quattrocento',
                                     vjust=0.2,
                                     size = 12, hjust=.5, margin=margin(2, 0, 5, 0)),
        plot.background = element_rect(fill = background_color2)) +
  labs(title = "Tsim Sha Tsui, Hong Kong", 
       subtitle = '114.1718° E, 22.2999° N')


blr_light
  
