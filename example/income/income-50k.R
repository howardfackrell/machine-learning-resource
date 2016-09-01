require('doMC')
registerDoMC(cores = 8)

columnNames <- c('age', 'workclass', 'fnlwgt', 'education', 'educationNum', 'maritalStatus', 'occupation', 'relationship', 'race', 'sex', 'capitalGain', 'capitalLoss', 'hoursPerWeek', 'nativeCountry', 'income')
featureCols <- c('income', 'age', 'workclass', 'fnlwgt', 'education', 'educationNum', 'maritalStatus', 'occupation', 'relationship', 'race', 'sex', 'capitalGain', 'capitalLoss', 'hoursPerWeek', 'nativeCountry')

prep50kData <- function(filename, columnNames, featureCols) {
  origData <- read.csv2(filename, sep=",", header=FALSE, stringsAsFactors=FALSE, col.names=columnNames)
  filteredData <- origData[origData$age !=""  & origData$workclass != " ?" & origData$education != " ?" & origData$maritalStatus != " ?" & origData$occupation != " ?"  & origData$relationship != " ?"  & origData$race != " ?"  & origData$sex != " ?"  & origData$nativeCountry != " ?"  & origData$income != " ?" & origData$income != "", ]
  
  filteredData$income <- gsub(".", "", filteredData$income, fixed=TRUE)
  
  filteredData$age <- as.integer(filteredData$age)
  filteredData$workclass <- as.factor(filteredData$workclass)
  filteredData$education <- as.factor(filteredData$education)
  filteredData$maritalStatus <- as.factor(filteredData$maritalStatus)
  filteredData$occupation <- as.factor(filteredData$occupation)
  filteredData$relationship <- as.factor(filteredData$relationship)
  filteredData$race <- as.factor(filteredData$race)
  filteredData$sex <- as.factor(filteredData$sex)
  filteredData$nativeCountry <- as.factor(filteredData$nativeCountry)
  filteredData$income <- as.factor(filteredData$income)
  preparedData <- filteredData[, featureCols]
  
  return( preparedData )
}

trainingData = prep50kData('~/tmp/income-50k/adult.data', columnNames = columnNames, featureCols = featureCols)
testingData = prep50kData('~/tmp/income-50k/adult.test', columnNames = columnNames, featureCols = featureCols)

library(caret)

set.seed(1235456)

logisticRegModel <- train(income ~ ., data = trainingData, method = "glm", family = "binomial")
logRegPrediction <- predict(logisticRegModel, testingData)

logRegConfMat <- confusionMatrix(logRegPrediction, testingData[,"income"])
logRegConfMat

set.seed(1235456)
#install.packages('elmNN')
elmRegModel <- train(income ~ ., data = trainingData, method = "elm")
elmPrediction <- predict(elmRegModel, testingData)

elmConfMat <- confusionMatrix(elmPrediction, testingData[,"income"])
elmConfMat

