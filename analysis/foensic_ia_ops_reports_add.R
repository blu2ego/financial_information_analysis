library(tidyverse)
library(caret)

index_train <- createDataPartition(imputed_full$target, p = .7, list = F)
training <- imputed_full[index_train, ]
testing  <- imputed_full[-index_train, ]

fitControl <- trainControl(method = "repeatedcv", number = 10, repeats = 5)

lm_fit <- train(target ~ ., data = training, method = "glm", trControl = fitControl)
tr_fit <- train(target ~ ., data = training, method = "rpart", trControl = fitControl, verbose = F, iter = 10)
rf_fit <- train(target ~ ., data = training, method = "rf", trControl = fitControl)
rf_yhat <- predict(rf_fit, newdata = testing)
rf_pred <- prediction(yhat_cart_test[, "1"], as.numeric(as.character(test$target)))
rf_perf <- performance(rf_pred, measure = 'tpr', x.measure = 'fpr')
performance(rf_pred, "auc")@y.values[[1]]

xgb_fit <- train(target ~ ., data = training, method = "xgbTree", trControl = fitControl, verbose = T)



plot(rf_perf, main = 'ROC Curve for Logistic Model', lty = 1)
plot(perf_glm_test, add = TRUE, lty = 2)
abline(0, 1)

rf_pred <- ifelse(rf_pred > 0.5, 1, 0)
confusionMatrix(as.factor(rf_pred), as.factor(testing$target))

roc_glm_test <- pROC::roc(response = test$target, predictor = yhat_glm_test)
roc_cart_test <- pROC::roc(response = test$target, predictor = yhat_cart_test)
roc_rf_test <- pROC::roc(response = test$target, predictor = yhat_rf_test)
roc_gbm_test <- pROC::roc(response = test$target, predictor = yhat_gbm_test)
roc_xgb_test <- pROC::roc(response = test$target, predictor = xgb.pred)

set.seed(1000)
roc_test_glm_cart <- pROC::roc.test(roc_glm_test, roc_cart_test, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_test_glm_cart

set.seed(1000)
roc_test_glm_rf <- pROC::roc.test(roc_glm_test, roc_rf_test, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_test_glm_rf

set.seed(1000)
roc_test_glm_gbm <- pROC::roc.test(roc_glm_test, roc_gbm_test, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_test_glm_gbm

set.seed(1000)
roc_test_glm_xgb <- pROC::roc.test(roc_glm_test, roc_xgb_test, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_test_glm_xgb

#######################################################################################################################

set.seed(1000)
roc_test_cart_rf <- pROC::roc.test(roc_cart_test, roc_rf_test, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_test_cart_rf

set.seed(1000)
roc_test_cart_gbm <- pROC::roc.test(roc_cart_test, roc_gbm_test, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_test_cart_gbm

set.seed(1000)
roc_test_cart_xgb <- pROC::roc.test(roc_rf_test, roc_gbm_test, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_test_cart_xgb

#######################################################################################################################

set.seed(1000)
roc_test_rf_gbn <- pROC::roc.test(roc_xgb_test, roc_xgb_test, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_test_rf_gbm

set.seed(1000)
roc_test_rf_xgb <- pROC::roc.test(roc_xgb_test, roc_xgb_test, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_test_rf_xgb

