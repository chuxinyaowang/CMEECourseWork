rm(list=ls())

load("../data/KeyWestAnnualMeanTemperature.RData")

ls()
class(ats)
head(ats)
plot(ats)
cor(ats$Year,ats$Temp)


corstore<-function(){
    corr<-rep(0,10) #create a list that include 10 '0'
    for (i in 1:10){
        #use sample to shuffle the temp in ats
        shuffle = lapply(ats, function(x) { sample(x) })
        corr[i]= cor(shuffle$Year,shuffle$Temp)
    }
    return(corr)

        }
corstore()