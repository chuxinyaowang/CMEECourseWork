rm(list = ls())
#load packages
library(ggplot2)
require("minpack.lm")
library(ggpubr)

#set path
setwd('../sandbox')
files<-dir()
DF1<- as.data.frame(matrix(nrow=285,ncol=3))
names(DF)<-c('AIClm1','AIClog_lm1_','AICpoly','AIClog_poly','AIClogistic','AICgompertz','AICclm1','AICclog_lm1','AICcpoly','AICclog_poly','AICclogistic','AICcgompertz','RSqlm1','RSqlog_lm1','RSqpoly','RSqlog_poly','RSqlogistic','RSqgompertz')
names(DF1)<-c('AIClm1','AICclm1','RSqlm1')
for (j in seq(1,length(files))){





#load data
mydata<-read.csv(file = files[j], header=T, sep=",")
#keep popbio value >= 0
mydata<-mydata[mydata$PopBio>=0,]
#head(mydata)






p1<- ggplot(mydata,aes(x=mydata$Time,y=log(mydata$PopBio)))+geom_point()+ labs(x="Time",y="log(Population)")
#p1

#linear fitting
#To find estimate growth rate(r)
lm1<-lm(mydata$PopBio~mydata$Time,data=mydata)
#summary(lm1)
linearmodel<-function(t,r,N_0){
    return(t*r+N_0)
}

timepoints<-mydata$Time

linear_points <- linearmodel(t = timepoints, 
         r = coef(lm1)[2],
         N_0 = coef(lm1)[1])
linear_df1 <- data.frame(timepoints, linear_points)
linear_df1$model <- "Linear equation"
names(linear_df1) <- c("Time", "PopBio", "model")

p_lm <- ggplot(mydata, aes(x = mydata$Time, y = mydata$PopBio)) +
 geom_point(size = 3) +
 geom_line(data = linear_df1, aes(x = Time, y = PopBio, col = model), size = 1) +
 theme(aspect.ratio=1)+
 labs(x = "Time", y = "Biological Population")
 #p_lm



############### R squared #####################
RSS_lm1<- sum(residuals(lm1)^2)
TSS_lm1 <- sum((linear_df1$PopBio - mean(linear_df1$PopBio))^2)
ARSq_lm1 <- 1 - (RSS_lm1/TSS_lm1)
RSq_lm1 <- 1 - ((1-ARSq_lm1)*length(mydata$PopBio)/(length(mydata$PopBio)-3-1))
###############################################


#####AIC Calculation########
#p = number of parameters, n = number of samples
lm1_rss<- sum((mydata$PopBio-linear_df1$PopBio)^2)
lm1_AIC <- length(mydata$PopBio) + 2 + length(mydata$PopBio) * log((2 * pi) / length(mydata$PopBio))+ length(mydata$PopBio) * log(lm1_rss) + 2 * 3
################AICc#################
lm1_AICc <-lm1_AIC+(2*3*(3+1))/(length(mydata$PopBio)-3-1)
value<-c(lm1_AIC,lm1_AICc,RSq_lm1)
DF1[j,]<-(value)

}


DF2<- as.data.frame(matrix(nrow=285,ncol=3))
names(DF2)<-c('AIClm2','AICclm2','RSqlm2')
for (j in seq(1,length(files))){

#load data
mydata<-read.csv(file = files[j], header=T, sep=",")
#keep popbio value > 0
mydata<-mydata[mydata$PopBio>0,] 

#Log linear model
#Add 1 column for log(mydata$PopBio)
mydata$log_PopBio<-log(mydata$PopBio)

lm2<-lm(mydata$log_PopBio~mydata$Time,data=mydata)
#summary(lm2)

linearmodel2<-function(t,r,logN_0){
    return(t*r+logN_0)
}

timepoints<-mydata$Time

linear_points <- linearmodel2(t = timepoints, 
         r = coef(lm2)[2],
         logN_0 = coef(lm2)[1])
linear_df2 <- data.frame(timepoints, linear_points)
linear_df2$model <- "Logrithm Linear equation"
names(linear_df2) <- c("Time", "Log_PopBio", "model")

p_lm2 <- ggplot(mydata, aes(x = mydata$Time, y = mydata$log_PopBio)) +
 geom_point(size = 3) +
 geom_line(data = linear_df2, aes(x = Time, y = Log_PopBio, col = model), size = 1) +
 theme(aspect.ratio=1)+
 labs(x = "Time", y = "Log(Biological Population)")
 #p_lm2



############### R squared #####################
RSS_lm2<- sum(residuals(lm2)^2)
TSS_lm2 <- sum((linear_df2$Log_PopBio - mean(linear_df2$Log_PopBio))^2)
ARSq_lm2 <- 1 - (RSS_lm2/TSS_lm2)
RSq_lm2 <- 1 - ((1-ARSq_lm2)*length(mydata$PopBio)/(length(mydata$PopBio)-3-1))
###############################################


#####AIC Calculation########
#p = number of parameters, n = number of samples
lm2_rss<- sum((mydata$PopBio-exp(linear_df2$Log_PopBio))^2)
lm2_AIC <- length(mydata$PopBio) + 2 + length(mydata$PopBio) * log((2 * pi) / length(mydata$PopBio)) + length(mydata$PopBio) * log(lm2_rss) + 2 * 3
################AICc#################
lm2_AICc <-lm2_AIC+(2*3*(3+1))/(length(linear_df2$PopBio)-3-1)

value<-c(lm2_AIC,lm2_AICc,RSq_lm2)
DF2[j,]<-(value)

}




DF3<- as.data.frame(matrix(nrow=285,ncol=3))
names(DF3)<-c('AICpoly','AICcpoly','RSqpoly')
for (j in seq(1,length(files))){

#load data
mydata<-read.csv(file = files[j], header=T, sep=",")
#keep popbio value > 0
mydata<-mydata[mydata$PopBio>0,] 

#Polynomial model
poly<-lm(mydata$PopBio~poly(mydata$Time,2,raw=TRUE),data=mydata)
#summary(poly)

polymodel<-function(t,a,b,N_0){
    return(a*(t^2)+b*t+N_0)
}

timepoints<-mydata$Time

poly_points <- polymodel(t = timepoints, 
         a = coef(poly)[3],  
         N_0 = coef(poly)[1],
         b = coef(poly)[2])
poly_df1 <- data.frame(timepoints, poly_points)
poly_df1$model <- "Polynomial equation"
names(poly_df1) <- c("Time", "PopBio", "model")


p_polylm <- ggplot(mydata, aes(x = mydata$Time, y = mydata$PopBio)) +
 geom_point(size = 3) +
 geom_line(data = poly_df1, aes(x = Time, y = PopBio, col = model), size = 1) +
 theme(aspect.ratio=1)+
 labs(x = "Time", y = "Biological Population")
 #p_polylm



############### R squared #####################
RSS_poly<- sum(residuals(poly)^2)
TSS_poly <- sum((poly_df1$PopBio - mean(poly_df1$PopBio))^2)
ARSq_poly <- 1 - (RSS_poly/TSS_poly)
RSq_poly <- 1 - ((1-ARSq_poly)*length(mydata$PopBio)/(length(mydata$PopBio)-4-1))
#########################AIC######################
###############################aic <- n + 2 + n * log((2 * pi) / n) + n * log(rss) + 2 * p
#p=4 n=length(mydata$PopBio)
poly_rss<- sum((mydata$PopBio-poly_df1$PopBio)^2)
poly_AIC <- length(mydata$PopBio) + 2 + length(mydata$PopBio) * log((2 * pi) / length(mydata$PopBio)) + length(mydata$PopBio) * log(poly_rss) + 2 * 4
######################AICc#########################
poly_AICc <-poly_AIC+(2*4*(4+1))/(length(mydata$PopBio)-4-1)



value<-c(poly_AIC,poly_AICc,RSq_poly)
DF3[j,]<-(value)

}



DF4<- as.data.frame(matrix(nrow=285,ncol=3))
names(DF4)<-c('AIClogpoly','AICclogpoly','RSqlogpoly')
for (j in seq(1,length(files))){

#load data
mydata<-read.csv(file = files[j], header=T, sep=",")
#keep popbio value > 0
mydata<-mydata[mydata$PopBio>0,] 


################log Polynomial model
log_poly<-lm(log(mydata$PopBio)~poly(mydata$Time,2,raw=TRUE),data=mydata)
#summary(log_poly)

polymodel<-function(t,a,b,log_N0){
    return(a*(t^2)+b*t+log_N0)
}

timepoints<-mydata$Time

poly_points <- polymodel(t = timepoints, 
         a = coef(log_poly)[3],  
         log_N0 = coef(log_poly)[1],
         b = coef(log_poly)[2])
logpoly_df1 <- data.frame(timepoints, poly_points)
logpoly_df1$model <- "Log of Polynomial equation"
names(logpoly_df1) <- c("Time", "Log_PopBio", "model")


p_logpolylm <- ggplot(mydata, aes(x = mydata$Time, y = log(mydata$PopBio))) +
 geom_point(size = 3) +
 geom_line(data = logpoly_df1, aes(x = Time, y = Log_PopBio, col = model), size = 1) +
 theme(aspect.ratio=1)+
 labs(x = "Time", y = "log(Biological Population)")
 #p_logpolylm


############### R squared #####################
RSS_logpoly<- sum(residuals(log_poly)^2)
TSS_logpoly <- sum((logpoly_df1$Log_PopBio - mean(logpoly_df1$Log_PopBio))^2)
ARSq_logpoly <- 1 - (RSS_logpoly/TSS_logpoly)
RSq_logpoly <- 1 - ((1-ARSq_logpoly)*length(mydata$PopBio)/(length(mydata$PopBio)-4-1))
#########################AIC######################
############################aic <- n + 2 + n * log((2 * pi) / n) + n * log(rss) + 2 * p
logpoly_rss<- sum((mydata$PopBio-exp(logpoly_df1$Log_PopBio))^2)
logpoly_AIC <- length(mydata$PopBio)+2+length(mydata$PopBio)*log((2*pi)/length(mydata$PopBio))+length(mydata$PopBio)*log(logpoly_rss)+2*4
######################AICc#########################
logpoly_AICc <-logpoly_AIC+(2*4*(4+1))/(length(mydata$PopBio)-4-1)

value<-c(logpoly_AIC,logpoly_AICc,RSq_logpoly)
DF4[j,]<-(value)

}



DF5<- as.data.frame(matrix(nrow=285,ncol=3))
names(DF5)<-c('AIClogistic','AICclogistic','RSqlogistic')
for (j in seq(1,length(files))){

#load data
mydata<-read.csv(file = files[j], header=T, sep=",")
#keep popbio value > 0
mydata<-mydata[mydata$PopBio>0,]
#delete time < 0
mydata<-mydata[mydata$Time>0,]
#make sure time slots are in order
mydata<-mydata[order(mydata$Time),]
#Non-Linear model fitting
#OLS
estimate_r<-max(diff(log(mydata$PopBio)))/abs((mydata$Time[which.max(diff(log(mydata$PopBio)))]-mydata$Time[which.max(diff(log(mydata$PopBio)))+1]))
 #Estimate r from ols_growth


#NLLS using logistic model
logistic_model <- function(t, r_max, K, N_0){
 return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
}

#fit starting parameters for the model
N_0_start <- min(mydata$PopBio) # lowest population size
K_start <- max(mydata$PopBio) # highest population size
r_max_start <- estimate_r # use estimate from the OLS fittinfg

fit_logistic <- try(nlsLM(mydata$PopBio ~ logistic_model(t = mydata$Time, r_max, K, N_0), data=mydata,
      start=list(r_max=r_max_start, N_0 = N_0_start, K = K_start),control=nls.lm.control(maxiter=500)))
if("try-error"%in% class(fit_logistic)){
        DF5[j,]<-(NA)
        next
    } else {

#summary(fit_logistic)



timepoints <- mydata$Time
#use try function to set all unsuccessful fitting to NA
logistic_points <- try(logistic_model(t = timepoints, 
         r_max = coef(fit_logistic)["r_max"], 
         K = coef(fit_logistic)["K"], 
         N_0 = coef(fit_logistic)["N_0"]))
    if("try-error"%in% class(logistic_points)){ 
        DF5[j,]<-(NA)
        next
    } else {
logistic_points <-logistic_model(t = timepoints, 
         r_max = coef(fit_logistic)["r_max"], 
         K = coef(fit_logistic)["K"], 
         N_0 = coef(fit_logistic)["N_0"])}
logistic_df1 <- data.frame(timepoints, logistic_points)

logistic_df1$model <- "Logistic equation"
names(logistic_df1) <- c("Time", "PopBio", "model")

p_nlsLM <- ggplot(mydata, aes(x = mydata$Time, y = mydata$PopBio)) +
 geom_point(size = 3) +
 geom_line(data = logistic_df1, aes(x = Time, y = PopBio, col = model), size = 1) +
 theme(aspect.ratio=1)+
 labs(x = "Time", y = "Biological Population")
 #p_nlsLM




########### R squared ###################
RSS_Logistic <- sum(residuals(fit_logistic)^2)
TSS_Logistic <- sum((logistic_df1$PopBio - mean(logistic_df1$PopBio))^2)
ARSq_Logistic <- 1 - (RSS_Logistic/TSS_Logistic)
RSq_Logistic<- 1 - ((1-ARSq_Logistic)*length(mydata$PopBio)/(length(mydata$PopBio)-4-1))
###########AIC############ 
############################aic <- n + 2 + n * log((2 * pi) / n) + n * log(rss) + 2 * p
###########p = 4, n = length(logistic_df1$PopBio)
logistic_rss<- sum((mydata$PopBio-logistic_df1$PopBio)^2)
logistic_AIC <- length(logistic_df1$PopBio) + 2 + length(logistic_df1$PopBio) * log((2*pi)/length(logistic_df1$PopBio))+ length(logistic_df1$PopBio) * log(logistic_rss) + 2 * 4
##################AICc############################
####################AICc <- aic + (2*p * (p + 1)) / (n - p - 1)
logistic_AICc <-logistic_AIC+(2*4*(4+1))/ (length(logistic_df1$PopBio)-4-1)

value<-c(logistic_AIC,logistic_AICc,RSq_Logistic)
DF5[j,]<-(value)

}
}

#fit in logrithm one
 p_log_nlsLM <- ggplot(mydata, aes(x = mydata$Time, y = log(mydata$PopBio) )) +
 geom_point(size = 3) +
 geom_line(data = logistic_df1, aes(x = Time, y = log(PopBio), col = model), size = 1) +
 theme(aspect.ratio=1)+ 
 labs(x = "Time", y = "log(Biological Population)")
#p_log_nlsLM
log_p<-ggplot(mydata, aes(x = mydata$PopBio, y = log(mydata$PopBio))) +
 geom_point(size = 3) +
 theme(aspect.ratio = 1)+ 
 labs(x = "N", y = "log(Popbio)")






DF6<- as.data.frame(matrix(nrow=285,ncol=3))
names(DF6)<-c('AICgompertz','AICcgompertz','RSqgompertz')
for (j in seq(1,length(files))){
    #load data
    mydata<-read.csv(file = files[j], header=T, sep=",")
    #keep popbio value > 0
    mydata<-mydata[mydata$PopBio>0,] 
    estimate_r<-max(diff(log(mydata$PopBio)))/abs(mean(diff(mydata$Time)))


#using Gompertz model
    # Modified gompertz growth model (Zwietering 1990)
 gompertz_model <- function(t, r_max, K, N_0, t_lag){ 
 return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}


N_0_start <- min(log(mydata$PopBio)) # lowest population size, note log scale
K_start <- max(log(mydata$PopBio)) # highest population size, note log scale
r_max_start <- estimate_r # use our previous estimate from the OLS fitting from above
t_lag_start <- mydata$Time[which.max(diff(diff(log(mydata$PopBio))))] # find last timepoint of lag phase


#fit Gompertz by using above starting data
fit_gompertz <- try(nlsLM(log(mydata$PopBio) ~ gompertz_model(t = mydata$Time, r_max, K, N_0, t_lag), 
start=list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, K = K_start),data=mydata,control = nls.lm.control(maxiter = 500)))
if("try-error"%in% class(fit_gompertz)){
        DF6[j,]<-(NA)
        next
    } else {

#summary(fit_gompertz)

timepoints <- mydata$Time

logistic_points <- log(logistic_model(t = timepoints, 
          r_max = coef(fit_logistic)["r_max"], 
          K = coef(fit_logistic)["K"], 
          N_0 = coef(fit_logistic)["N_0"]))

gompertz_points <- gompertz_model(t = timepoints, 
         r_max = coef(fit_gompertz)["r_max"], 
         K = coef(fit_gompertz)["K"], 
         N_0 = coef(fit_gompertz)["N_0"], 
         t_lag = coef(fit_gompertz)["t_lag"])

logistic_df2 <- data.frame(timepoints, logistic_points)
logistic_df2$model <- "Logistic model"
names(logistic_df2) <- c("Time", "Log_PopBio", "model")

logistic_df3 <- data.frame(timepoints, gompertz_points)
logistic_df3$model <- "Gompertz model"
names(logistic_df3) <- c("Time", "Log_PopBio", "model")

model_frame <- rbind(logistic_df2, logistic_df3)

p_gompertz<-ggplot(mydata, aes(x = mydata$Time, y = log(mydata$PopBio))) +
geom_point(size = 3) +
geom_line(data = model_frame, aes(x = model_frame$Time, y = model_frame$Log_PopBio, col = model_frame$model), size = 1) + 
theme(aspect.ratio = 1)+
labs(x = "Time", y = "log(PopBio)")
#p_gompertz

###########Adjusted R squared ###################
RSS_Gompertz <- sum(residuals(fit_gompertz)^2)
TSS_Gompertz <- sum((logistic_df3$Log_PopBio - mean(logistic_df3$Log_PopBio))^2)
ARSq_Gompertz <- 1 - (RSS_Gompertz/TSS_Gompertz)
RSq_Gompertz <- 1 - ((1-ARSq_Gompertz)*length(mydata$PopBio)/(length(mydata$PopBio)-4-1))
########################################


###########AIC############ 
############################aic <- n + 2 + n * log((2 * pi) / n) + n * log(rss) + 2 * p
###########p = 4, n = length(logistic_df1$PopBio) = mydata$PopBio
gompertz_rss<- sum((mydata$PopBio-exp(logistic_df3$Log_PopBio))^2)
gompertz_AIC <- length(mydata$PopBio) + 2 + length(mydata$PopBio) * log((2*pi)/length(mydata$PopBio))+ length(mydata$PopBioo) * log(gompertz_rss) + 2 * 4

####################AICc <- aic + (2*p * (p + 1)) / (n - p - 1)
gompertz_AICc <-gompertz_AIC+(2*4*(4+1))/ (length(mydata$PopBio)-4-1)

value<-c(gompertz_AIC,gompertz_AICc,RSq_Gompertz)
DF6[j,]<-(value)
}
}
#delete NA NaN Inf value
DF1<-DF1[!is.nan((rowSums(DF1[1:3])))&!is.infinite(rowSums(DF1[1:3]))&!is.na(rowSums(DF1[1:3])),]
DF2<-DF2[!is.nan((rowSums(DF2[1:3])))&!is.infinite(rowSums(DF2[1:3]))&!is.na(rowSums(DF2[1:3])),]
DF3<-DF3[!is.nan((rowSums(DF3[1:3])))&!is.infinite(rowSums(DF3[1:3]))&!is.na(rowSums(DF3[1:3])),]
DF4<-DF4[!is.nan((rowSums(DF4[1:3])))&!is.infinite(rowSums(DF4[1:3]))&!is.na(rowSums(DF4[1:3])),]
DF5<-DF5[!is.nan((rowSums(DF5[1:3])))&!is.infinite(rowSums(DF5[1:3]))&!is.na(rowSums(DF5[1:3])),]
DF6<-DF6[!is.nan((rowSums(DF6[1:3])))&!is.infinite(rowSums(DF6[1:3]))&!is.na(rowSums(DF6[1:3])),]

#Type name
DF1$model<-"linear model"
DF2$model<-"log linear model"
DF3$model<-"polynomial model"
DF4$model<-"log polynomial model"
DF5$model<-"logistic model"
DF6$model<-"gompertz model"
listmodels<-c(DF1$model,DF2$model,DF3$model,DF4$model,DF5$model,DF6$model)
#create three DFfor three values
listAIC<-c(DF1$AIClm1,DF2$AIClm2,DF3$AICpoly,DF4$AIClogpoly,DF5$AIClogistic,DF6$AICgompertz)
DFAIC<-data.frame(listAIC,listmodels)
names(DFAIC)<-c('AIC','Modeltype')

listAICc<-c(DF1$AICclm1,DF2$AICclm2,DF3$AICcpoly,DF4$AICclogpoly,DF5$AICclogistic,DF6$AICcgompertz)
DFAICc<-data.frame(listAICc,listmodels)
names(DFAICc)<-c('AICc','Modeltype')

listRSq<-c(DF1$RSqlm1,DF2$RSqlm2,DF3$RSqpoly,DF4$RSqlogpoly,DF5$RSqlogistic,DF6$RSqgompertz)
DFRSq<-data.frame(listRSq,listmodels)
names(DFRSq)<-c('RSq','Modeltype')



#plot

boxplotAIC <- ggplot(DFAIC, aes(DFAIC$Modeltype, DFAIC$AIC,color=DFAIC$Modeltype)) + geom_boxplot() +
    theme(axis.text.x = element_text(angle=60, vjust=1, hjust=1),legend.position = "bottom")+
    labs(title="AIC boxplot",x = "Model type", y = "AIC")

boxplotAICc <- ggplot(DFAICc, aes(DFAICc$Modeltype, DFAICc$AIC,color=DFAICc$Modeltype))+ geom_boxplot()+
    theme(axis.text.x = element_text(angle=60, vjust=1, hjust=1),legend.position = "bottom")+
    labs(title="AICc boxplot",x = "Model type", y = "AICc")

boxplotRSq<-ggplot(DFRSq, aes(x=DFRSq$Modeltype, y=DFRSq$RSq,color=DFRSq$Modeltype)) + geom_boxplot() +
    theme(axis.text.x = element_text(angle=60, vjust=1, hjust=1),legend.position = "bottom")+
    ylim(-2,2)+
    labs(title="Adjusted R squared boxplot",x = "Model type", y = "RSq")

pall<-ggarrange(boxplotAIC,boxplotAICc,boxplotRSq,ncol=3,nrow=1,common.legend=FALSE,legend='right')


meanAIC<-c(mean(DF1$AIClm1),mean(DF2$AIClm2),mean(DF3$AICpoly),mean(DF4$AIClogpoly),mean(DF5$AIClogistic),mean(DF6$AICgompertz))
medianAIC<-c(median(DF1$AIClm1),median(DF2$AIClm2),median(DF3$AICpoly),median(DF4$AIClogpoly),median(DF5$AIClogistic),median(DF6$AICgompertz))
minAIC<-c(min(DF1$AIClm1),min(DF2$AIClm2),min(DF3$AICpoly),min(DF4$AIClogpoly),min(DF5$AIClogistic),min(DF6$AICgompertz))
maxAIC<-c(max(DF1$AIClm1),max(DF2$AIClm2),max(DF3$AICpoly),max(DF4$AIClogpoly),max(DF5$AIClogistic),max(DF6$AICgompertz))

meanAICc<-c(mean(DF1$AICclm1),mean(DF2$AICclm2),mean(DF3$AICcpoly),mean(DF4$AICclogpoly),mean(DF5$AICclogistic),mean(DF6$AICcgompertz))
medianAICc<-c(median(DF1$AICclm1),median(DF2$AICclm2),median(DF3$AICcpoly),median(DF4$AICclogpoly),median(DF5$AICclogistic),median(DF6$AICcgompertz))
minAICc<-c(min(DF1$AICclm1),min(DF2$AICclm2),min(DF3$AICcpoly),min(DF4$AICclogpoly),min(DF5$AICclogistic),min(DF6$AICcgompertz))
maxAICc<-c(max(DF1$AICclm1),max(DF2$AICclm2),max(DF3$AICcpoly),max(DF4$AICclogpoly),max(DF5$AICclogistic),max(DF6$AICcgompertz))

meanRSq<-c(mean(DF1$RSqlm1),mean(DF2$RSqlm2),mean(DF3$RSqpoly),mean(DF4$RSqlogpoly),mean(DF5$RSqlogistic),mean(DF6$RSqgompertz))
medianRSQ<-c(median(DF1$RSqlm1),median(DF2$RSqlm2),median(DF3$RSqpoly),median(DF4$RSqlogpoly),median(DF5$RSqlogistic),median(DF6$RSqgompertz))
minRSq<-c(min(DF1$RSqlm1),min(DF2$RSqlm2),min(DF3$RSqpoly),min(DF4$RSqlogpoly),min(DF5$RSqlogistic),min(DF6$RSqgompertz))
maxRSq<-c(max(DF1$RSqlm1),max(DF2$RSqlm2),max(DF3$RSqpoly),max(DF4$RSqlogpoly),max(DF5$RSqlogistic),max(DF6$RSqgompertz))


#conclude the RSq AIC AICc

modeltype<-c('linear model','log linear mdoel','polynomial model','log polynomial model','logistic model','gompertz model')
aicall<-data.frame(modeltype,meanAIC,medianAIC,minAIC,maxAIC)
names(aicall)<-c('model type','mean','median','min','max')

aiccall<-data.frame(modeltype,meanAICc,medianAICc,minAICc,maxAICc)
names(aiccall)<-c('model type','mean','median','min','max')

rsqall<-data.frame(modeltype,meanRSq,medianRSQ,minRSq,maxRSq)
names(rsqall)<-c('model type','mean','median','min','max')
#file store
write.csv(aicall,'../results/aic.csv')
write.csv(aiccall,'../results/aicc.csv')
write.csv(rsqall,'../results/rsq.csv')

#plot store
ggsave(boxplotAIC, file='../results/aic.pdf', width=12, height=10)
ggsave(boxplotAICc, file='../results/aicc.pdf', width=12, height=10)
ggsave(boxplotRSq, file='../results/rsq.pdf', width=12, height=10)