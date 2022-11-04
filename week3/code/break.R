#Breaking out of loops
i <- 0 #Initialize i
    while (i < Inf){
        if (i == 10) {
            break()
        } else {
            cat("i euqals", i, "\n")
            i <- i + 1
        }
    }