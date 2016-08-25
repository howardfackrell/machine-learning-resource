origData <- read.csv2('~/tmp/582845192_T_ONTIME.csv', sep=",", header=TRUE, stringsAsFactors=FALSE)

nrow(origData)

airports <- c('ATL','LAX','ORD','DFW','JFK','SFO','CLT','LAS','PHX')
              
origData <- subset(origData, DEST %in% airports & ORIGIN %in% airports)
              
nrow(origData)
              
head(origData,2)
tail (origData, 2)
              
origData$X <- NULL
head(origData,2)
              
cor(origData[c("ORIGIN_AIRPORT_SEQ_ID", "ORIGIN_AIRPORT_ID")])
              
cor(origData[c("ORIGIN_AIRPORT_SEQ_ID", "ORIGIN_AIRPORT_ID")])
cor(origData[c("DEST_AIRPORT_SEQ_ID", "DEST_AIRPORT_ID")])
origData$ORIGIN_AIRPORT_SEQ_ID <- NULL
origData$DEST_AIRPORT_SEQ_ID <- NULL

mismatched <- origData[origData$CARRIER != origData$UNIQUE_CARRIER,]
nrow(mismatched)
origData$UNIQUE_CARRIER <- NULL

onTimeData <- origData[!is.na(origData$ARR_DEL15) & origData$ARR_DEL15!="" & !is.na(origData$DEP_DEL15) & origData$DEP_DEL15!="",]

nrow(origData)
nrow(onTimeData)

onTimeData$DISTANCE <- as.integer(onTimeData$DISTANCE)
onTimeData$CANCELLED <- as.integer(onTimeData$CANCELLED)
onTimeData$DIVERTED <- as.integer(onTimeData$DIVERTED)
onTimeData$ARR_DEL15 <- as.factor(onTimeData$ARR_DEL15)
onTimeData$DEP_DEL15 <- as.factor(onTimeData$DEP_DEL15)
onTimeData$DEST_AIRPORT_ID <- as.factor(onTimeData$DEST_AIRPORT_ID)
onTimeData$ORIGIN_AIRPORT_ID <- as.factor(onTimeData$ORIGIN_AIRPORT_ID)
onTimeData$DAY_OF_WEEK <- as.factor(onTimeData$DAY_OF_WEEK)
onTimeData$DEST <- as.factor(onTimeData$DEST)
onTimeData$ORIGIN <- as.factor(onTimeData$ORIGIN)
onTimeData$DEP_TIME_BLK <- as.factor(onTimeData$DEP_TIME_BLK)
onTimeData$CARRIER <- as.factor(onTimeData$CARRIER)

tapply(onTimeData$ARR_DEL15, onTimeData$ARR_DEL15, length)
(6460 / (25664 + 6460))

# Training 
# The Caret Package only needs to be installed once
#install.packages('caret')
library(caret)

set.seed(122515)
featureCols <- c("ARR_DEL15", "DAY_OF_WEEK", "CARRIER", "DEST", "ORIGIN", "DEP_TIME_BLK")
onTimeDataFiltered <- onTimeData[,featureCols]
inTrainRows <- createDataPartition(onTimeDataFiltered$ARR_DEL15, p=0.70, list=FALSE)
head(inTrainRows, 10)

trainDataFiltered <- onTimeDataFiltered[inTrainRows,]
testDataFiltered <- onTimeDataFiltered[-inTrainRows,]
nrow(trainDataFiltered)/(nrow(testDataFiltered) + nrow(trainDataFiltered))
nrow(testDataFiltered)/(nrow(testDataFiltered) + nrow(trainDataFiltered))

logisticRegModel <- train(ARR_DEL15 ~ ., data=trainDataFiltered, method="glm", family="binomial")

# I also had to install this package for the training to run
#install.packages("e1071")

logisticRegModel

# Testing and refining the Trained Model
logRegPrediction <- predict(logisticRegModel, testDataFiltered)
logRegConfMat <- confusionMatrix(logRegPrediction, testDataFiltered[,"ARR_DEL15"])
logRegConfMat

#install.packages('randomForest')
library(randomForest)

rfModel <- randomForest(trainDataFiltered[-1], trainDataFiltered$ARR_DEL15, proximity = TRUE, importance = TRUE)
rfValidation <- predict(rfModel, testDataFiltered)
rfConfMat <- confusionMatrix(rfValidation, testDataFiltered[,"ARR_DEL15"])
rfConfMat
