#Load library and Data
library(randomForest)
data =  read.csv("day.csv")

#Split data into Test and Train
library(dplyr)
data <- data[,-c(1,2,4,6,15,14)]
train <- sample(nrow(data), 0.7*nrow(data), replace = FALSE)
Train <- data[train,]
Valid <- data[-train,]
names(data)

#Random Forest
train <- sample(nrow(data), 0.7*nrow(data), replace = FALSE)
Train <- data[train,]
Valid <- data[-train,]
rfFit = randomForest(cnt ~ .,                     # formula
                 data = Train,                   # data set
                 ntree = 500,                   # number of trees
                 mtry = 3,                     # variables for split
                 importance = TRUE)

#RMSE Prediction
test.pred.forest <- predict(rfFit,Valid)
RMSE.forest <- sqrt(mean((test.pred.forest-Valid$cnt)^2))
RMSE.forest


#Sample Input

write.csv(Valid, "Sample_Input.csv", row.names = T)

#adding predicted column to the data set
Valid$Prediction <- predict(rfFit,Valid)

write.csv(Valid, "Sample_Output", row.names = T)
