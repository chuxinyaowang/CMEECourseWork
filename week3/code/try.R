doit <- function(x) {
    temp_x <- sample(x, replace = TRUE)
    if (length(unique(temp_x)) > 30) {
        print(paste("Mean of this sample was:", as.character(mean(temp_x))))
        }
    else {
        stop("Couldn't calculate mean: too few unique values!")
    }
}

set.seed(1345)
popn <- rnorm(50)
hist(popn)

lapply(1:15, function(i) doit(popn))



result <- lapply(1:15, function(i) try(doit(popn), FALSE))



class(result)
rresult


result <- vector("list", 15) #Preallocate/Initialize
for(i in 1:15) {
    result[[i]]  <- try(doit(popn),FALSE)
}