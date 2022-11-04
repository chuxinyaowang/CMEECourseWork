# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"
TreeHts <- read.csv("../data/trees.csv",header = FALSE)
TreeHts

distance.m= TreeHts[[2]][2:length(TreeHts[[2]])]
distance.m

angle.degrees= TreeHts[[3]][2:length(TreeHts[[3]])]
angle.degrees


#Convert character into numeric than do calculation

radians <- as.numeric(angle.degrees) * pi / 180
Tree.height.m <- as.numeric(distance.m) * tan(radians)
print(Tree.height.m)


species <- TreeHts[[1]] [2:length(TreeHts[[1]])]
species

TreeHts1 <- data.frame(species,distance.m,angle.degrees,Tree.height.m)
TreeHts1
write.csv(TreeHts1, "../results/TreeHts.csv")
dir("../results/")