# ------------
# FFTrees Demo with heartdisease data
# ------------

# Install package
#install.packages("FFTrees")

# Load library
library(FFTrees)

# Create FFTrees object
heart.fft <- FFTrees(formula = diagnosis ~ .,
                     data = heartdisease)

# Print object
heart.fft

# Show cue accuracies
plot(heart.fft, 
     what = "cues", main = "Heart Disease")

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



png(filename = "mydeck/images/heartsim.png", width = 12, height = 7, units = "in", res = 400)
## Training
par(mfrow = c(1, 2))
pirateplot(data = data.frame("Random" = rnorm(100, mean = .5, sd = .01),
                            "FFTrees" = heart.fff$tree.sim$bacc.train, 
                             "rpart" = heart.fff$cart.sim$bacc.train, 
                             "lm" = heart.fff$lr.sim$bacc.train, 
                             "rForest" = heart.fff$rf.sim$bacc.train),
           ylim = c(.5, 1), yaxt = "n", gl = seq(.5, 1, .05),  gl.lwd = c(.75, .25),
           main = "Heartdisease - Fitting", ylab = "Balanced Accuracy", sortx = "s", xlab = "Model")
axis(2, at = seq(.5, 1, .1), las = 1)

pirateplot(data = data.frame("Random" = rnorm(100, mean = .5, sd = .01),
                              "FFTrees" = heart.fff$tree.sim$bacc.test, 
                             "rpart" = heart.fff$cart.sim$bacc.test, 
                             "lm" = heart.fff$lr.sim$bacc.test, 
                             "rForest" = heart.fff$rf.sim$bacc.test),
           ylim = c(.5, 1), yaxt = "n", gl = seq(.5, 1, .05),  gl.lwd = c(.75, .25),
           main = "Heartdisease - Prediction", ylab = "Balanced Accuracy", sortx = "s", xlab = "Model")
axis(2, at = seq(.5, 1, .1), las = 1)

dev.off()
