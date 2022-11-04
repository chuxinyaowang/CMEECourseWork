# Runs the stochastic Ricker equation with gaussian fluctuations

rm(list = ls())

stochrick <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{

  N <- matrix(NA, numyears, length(p0))  #initialize empty matrix

  N[1, ] <- p0

  for (pop in 1:length(p0)) { #loop through the populations

    for (yr in 2:numyears){ #for each pop, loop through the years

      N[yr, pop] <- N[yr-1, pop] * exp(r * (1 - N[yr - 1, pop] / K) + rnorm(1, 0, sigma)) # add one fluctuation from normal distribution
    
     }
  
  }
 return(N)

}

# Now write another function called stochrickvect that vectorizes the above to
# the extent possible, with improved performance: 

# print("Vectorized Stochastic Ricker takes:")
# print(system.time(res2<-stochrickvect()))


#First I create a function to put the function in.
stochrickfunc<- function(N,r = 1.2, K = 1, sigma = 0.2,numyears = 100) {
  for (yr in 2:100)
      N[yr] <- N[yr-1] * exp(r * (1 - N[yr - 1] / K) + rnorm(1, 0, sigma))

    return(N)
}

#THis function is for implementing the function above.
stochrickvect<- function(){
  p0<-c(runif(1000, .5, 1.5))

  A<-matrix(p0,ncol=1000,nrow=100, byrow = T)
  #create a matrix that each column has same p0 value
  #use "apply" to fill the matrix by computing function, 
  #then replace all p0 value that I set
  result<- apply(A,2,stochrickfunc)
  #set first row to p0 back
  A[1,]<p0

  return (result)
  }
stochrickvect()
print("Vectorized Stochastic Ricker takes:")
print(system.time(stochrickvect()))

print("Stochastic Ricker takes:")
print(system.time(stochrick()))