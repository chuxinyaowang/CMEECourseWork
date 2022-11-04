rm(list=ls())

MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
head(MyDF)
require(tidyverse)
require(dplyr)
glimpse(MyDF)

MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)
#Find number of types of predation interaction
# unique(MyDF[,8]), there are five: 
#planktivorous, predacious, piscivorous, insectivorous, predacious/piscivorous
t1<- subset(MyDF,Type.of.feeding.interaction== 'planktivorous')
t2<- subset(MyDF,Type.of.feeding.interaction== 'predacious')
t3<- subset(MyDF,Type.of.feeding.interaction== 'piscivorous')
t4<- subset(MyDF,Type.of.feeding.interaction== 'insectivorous')
t5<- subset(MyDF,Type.of.feeding.interaction== 'predacious/piscivorous')



#1. make the subplot for predator mass
pdf("../results/Pred_Subplots.pdf", 11.7, 8.3)

par(mfcol = c(2,3))

hist(log(t1$Predator.mass),
xlab="log10(Predator Mass(g)",
ylab="Count",
main="planktivorous")


hist(log(t2$Predator.mass),
xlab="log10(Predator Mass(g)",
ylab="Count",
main="predacious")

hist(log(t3$Predator.mass),
xlab="log10(Predator Mass(g)",
ylab="Count",
main="piscivorous")

hist(log(t4$Predator.mass),
xlab="log10(Predator Mass(g)",
ylab="Count",
main="insectivorous")

hist(log(t5$Predator.mass),
xlab="log10(Predator Mass(g)",
ylab="Count",
main="predacious/piscivorous")

graphics.off()

#2. make the subplot for prey mass

pdf("../results/Prey_Subplots.pdf", 11.7, 8.3)

par(mfcol = c(2,3))

hist(log(t1$Prey.mass),
xlab="log10(Prey Mass(g)",
ylab="Count",
main="planktivorous")

hist(log(t1$Prey.mass),
xlab="log10(Prey Mass(g)",
ylab="Count",
main="predacious")

hist(log(t1$Prey.mass),
xlab="log10(Prey Mass(g)",
ylab="Count",
main="piscivorous")

hist(log(t1$Prey.mass),
xlab="log10(Prey Mass(g)",
ylab="Count",
main="insectivorous")

hist(log(t1$Prey.mass),
xlab="log10(Prey Mass(g)",
ylab="Count",
main="predacious/piscivorous")

graphics.off()

#3.make the subplot for prey mass/predator mass (ratio)

#calculate the size ratio for each type of interaction

ratio1<- t1$Prey.mass/t1$Predator.mass
ratio2<- t2$Prey.mass/t2$Predator.mass
ratio3<- t3$Prey.mass/t3$Predator.mass
ratio4<- t4$Prey.mass/t4$Predator.mass
ratio5<- t5$Prey.mass/t5$Predator.mass

pdf("../results/SizeRatio_Subplots.pdf", 11.7, 8.3)

par(mfcol = c(2,3))
hist(log(ratio1),
xlab="log10(Prey Mass/Predator Mass",
ylab="Count",
main="Size ratio distribution for planktivorous")

hist(log(ratio2),
xlab="log10(Prey Mass/Predator Mass",
ylab="Count",
main="Size ratio distribution for predacious")

hist(log(ratio3),
xlab="log10(Prey Mass/Predator Mass",
ylab="Count",
main="Size ratio distribution for piscivorous")

hist(log(ratio4),
xlab="log10(Prey Mass/Predator Mass",
ylab="Count",
main="Size ratio distribution for insectivorous")

hist(log(ratio5),
xlab="log10(Prey Mass/Predator Mass",
ylab="Count",
main="Size ratio distribution for predacious/piscivorous")

graphics.off()



#calculate the mean, median for each type

#ratio
ratio<- MyDF$Prey.mass/MyDF$Predator.mass

mean1<- split(log(MyDF$Predator.mass), 
(MyDF$Type.of.feeding.interaction))
predmean<-sapply(mean1,mean)

mean2<- split(log(MyDF$Prey.mass), 
(MyDF$Type.of.feeding.interaction))
preymean<-sapply(mean2,mean)

mean3<- split(log(ratio), 
MyDF$Type.of.feeding.interaction)
ratiomean<-sapply(mean3,mean)

#median
median1<- split(log(MyDF$Predator.mass), 
(MyDF$Type.of.feeding.interaction))
predmedian<-sapply(median1,median)

median2<- split(log(MyDF$Prey.mass), 
(MyDF$Type.of.feeding.interaction))
preymedian<-sapply(median2,median)

median3<- split(log(ratio), 
MyDF$Type.of.feeding.interaction)
ratiomedian<-sapply(median3,median)
class(ratiomean)

#merge into a dataframe
results<- data.frame(
predmean,preymean,ratiomean,predmedian,preymedian,ratiomedian)
names(results)<- c("MeanforPredator","MeanforPrey", 
"MeanforRatio","MedianforPredator", "MedianforPrey","MedianforRatio")

write.csv(results,"../results/PP_Results.csv",row.names=T)
