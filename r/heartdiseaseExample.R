# ------------
# FFTrees Demo with heartdisease data
# ------------

# Install package
#install.packages("FFTrees")

# Load library
library(FFTrees)

# Create FFTrees object
heart.fft <- FFTrees(formula = diagnosis ~ thal + ca + slope,
                     data = heartdisease)

# Print object
heart.fft

# Show cue accuracies
plot(heart.fft, 
     what = "cues", 
     main = "Heart Disease")

# Plot best fitting tree (no stats)

plot(heart.fft, 
     main = "Heart Disease", 
     decision.names = c("Healthy", "Diseased"), 
     stats = FALSE)


# Plot best fitting tree (with stats)
plot(heart.fft, 
     main = "Heart Disease", 
     decision.names = c("Healthy", "Diseased"))



# Contrast with standard decision tree

library(rpart)
heart.rpart <- rpart(diagnosis ~., 
                     data = heartdisease)
plot(heart.rpart)
text(heart.rpart)


# Create FFForest object
# library(snow)
# heart.fff <- FFForest(diagnosis ~ .,
#                       data = heartdisease,
#                       ntree = 50, cpus = 4)

# Plot FFForest object
plot(heart.fff)


