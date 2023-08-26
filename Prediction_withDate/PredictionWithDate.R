install.packages("randomForest")
library(randomForest)

data <- read.csv("file_path//file.csv", header = TRUE)

data$date <- as.Date(data$date)

data_numeric <- data[, sapply(data, is.numeric)]
colnames(data_numeric) <- make.names(colnames(data_numeric))

set.seed(123)
train_indices <- sample(1:nrow(data_numeric), 0.8 * nrow(data_numeric))
train_data <- data_numeric[train_indices, ]
test_data <- data_numeric[-train_indices, ]

train_data <- na.omit(train_data)

model <- randomForest(TargetVariable ~ ., data = train_data, ntree = 100)

prediction_data <- test_data

prediction_dates <- data$date[-train_indices]

predictions <- data.frame(Date = prediction_dates, Prediction = predict(model, newdata = prediction_data))

print(predictions)

write.csv(predictions, "save_file_path//output_file.csv", fileEncoding = "UTF-8", row.names = FALSE)
