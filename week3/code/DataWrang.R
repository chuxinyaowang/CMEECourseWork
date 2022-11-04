MyData <- as.matrix(read.csv("../data/PoundHillData.csv",header = FALSE))
class(MyData)

MyMetaData <- read.csv("../data/PoundHillMetaData.csv",header = TRUE,  sep=";")
class(MyMetaData)

head(MyData)

MyMetaData

#replace those blanks with zeros:
MyData[MyData == ""] = 0


MyData <- t(MyData)
head(MyData)

colnames(MyData)

#create a temporary dataframe with just the data, without the column names:
TempData <- as.data.frame(MyData[-1,],default.stringsAsFactors = F)
head(TempData)
#Note that stringsAsFactors = F is important here
#because we don’t want R to convert
#columns to the factor class without supervision


#assign the original column names to the temporary dataset:
colnames(TempData) <- MyData[1,]
head(TempData)

#If get rid of rownames of TempData:
rownames(TempData) <-NULL
head(TempData)

#Both library() and require() are commands/functions to load packages
#difference is that require() is designed for use inside other functions, 
#so it returns FALSE and gives a warning,
#whereaslibrary() returns an error by default if the package does not exist.

require(reshape2) #load the reshape2 package

#wrangle the dataset
MyWrangledData <- melt(TempData, id = 
c("Cultivation", "Block", "Plot", "Quadrat"), 
variable.name="Species", value.name ="Count")

head(MyWrangledData); tail(MyWrangledData)

#assign correct data types to each column:
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])
str(MyWrangledData)


require(tidyverse)
tidyverse_packages(include_self = TRUE)
MyWrangledData <- dplyr::as_tibble(MyWrangledData)
MyWrangledData

MyWrangledData <- as_tibble(MyWrangledData)
class(MyWrangledData)

glimpse(MyWrangledData)
filter(MyWrangledData, count > 100)

slice(MyWrangledData, 10:15)


MyWrangledData %>%
    group_by(Species) %>%
        summarise(avg = mean(Count))

aggregate(MyWrangledData$Count, list(MyWrangledData$Species), FUN=mean)