install.packages("randomForest")
library(randomForest)

data <- read.csv("file_path//file.csv", header = TRUE)

data_numeric <- data[, sapply(data, is.numeric)]
colnames(data_numeric) <- make.names(colnames(data_numeric))

set.seed(123)
train_indices <- sample(1:nrow(data_numeric), 0.8 * nrow(data_numeric))
train_data <- data_numeric[train_indices, ]
test_data <- data_numeric[-train_indices, ]

train_data <- na.omit(train_data)

model <- randomForest(TargetVariable ~ ., data = train_data, ntree = 100)

importance_scores <- importance(model)
print(importance_scores)

importance_scores <- importance(model)
normalized_scores <- importance_scores / max(importance_scores) * 100

print(normalized_scores)

varImpPlot(model)

write.csv(normalized_scores, file = "save_file_path//outputfile.csv")
