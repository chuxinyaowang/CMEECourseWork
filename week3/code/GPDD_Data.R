install.packages("maps")
install.packages("ggmap")
install.packages("sp")
install.packages("maptools")
library("maps")
library(ggplot2)


GPDD<-load(file = "../data/GPDDFiltered.RData")
GPDD
gpdd
lat<-gpdd$lat
long<-gpdd$long
#creatr empty map
mp<-NULL 
#create base map
mapworld<-borders("world",colour="grey",fill="white")
#use ggplot to present map
mp<-ggplot()+mapworld+ylim(-60,90)
mp2<- mp+geom_point(aes(x=long,y=lat,size=1),colour="red")+scale_size(range=c(1,1))

mp3<-mp2+theme(legend.position = "none")

mp3


#what biases might you expect in any analysis based on the data represented?

#Answer: 
#Because the map is scaled, and the size of the point cannot be scaled down in order to be visible, 
#the position on the map may be different from the actual one, 
#and the position cannot be represented very accurately.

#2.The drawing of the map needs to consider different projection systems, 
#and sometimes the labeling of the location is misplaced on this basis. 
#If the data needs to be surveyed on the spot, there may be a problem of on-the-spot survey in the wrong place, 
#which will lead to the failure of the sample reliability.
