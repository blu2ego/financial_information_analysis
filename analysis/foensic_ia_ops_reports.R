##### Fraud Detection Based on Survival Analysis Using Machine Learning Approach #####

##### 감리지적 사례 정리 <- 목표 변수 #####

library(tidyverse)
library(readxl)
full <- read_excel("data/forensic/full.xlsx")

# 원래 열 이름을 별도로 저장해 둠
raw_full_col_names <- names(full)

# 열 이름을 새롭게 정의
new_col_names <- c("index", "name", "market_code", "market", "fiscal_year", "fiscal_month", "industry", "target", "auditor", "big4", 
                   "internal_audit", "external_audit", 
                   "growth_1", "growth_2", "growth_3", "growth_4", "growth_5", 
                   "growth_6", "growth_7", "growth_8", "growth_9", "growth_10", 
                   "growth_11", "growth_12", "growth_13", "growth_14",
                   "profit_1", "profit_2", "profit_3", "profit_4", "profit_5", 
                   "profit_6", "profit_7", "profit_8", "profit_9", "profit_10", 
                   "profit_11", "profit_12", "profit_13", "profit_14","profit_15", 
                   "profit_16", "profit_17", "profit_18", "profit_19", "profit_20", 
                   "profit_21", "profit_22", "profit_23", "profit_24", "profit_25", 
                   "profit_26", "profit_27", "profit_28", "profit_29", "profit_30", 
                   "profit_31", "profit_32", "profit_33", "profit_34", "profit_35", 
                   "profit_36", "profit_37", "profit_38", "profit_39", "profit_40",
                   "profit_41", "profit_42", "profit_43", "profit_44", "profit_45", 
                   "profit_46", "profit_47", "profit_48", "profit_49", "profit_50", 
                   "safety_1", "safety_2", "safety_3", "safety_4", "safety_5", 
                   "safety_6", "safety_7", "safety_8", "safety_9", "safety_10", 
                   "safety_11", "safety_12", "safety_13", "safety_14", "safety_15", 
                   "safety_16", "safety_17", "safety_18", "safety_19", "safety_20", 
                   "safety_21", "safety_22", "safety_23", "safety_24", "safety_25", 
                   "safety_26", "safety_27", "safety_28", "safety_29", "safety_30", 
                   "safety_31", "safety_32", "safety_33", "safety_34", "safety_35", 
                   "safety_36", "safety_37", "safety_38", "safety_39", 
                   "activity_1", "activity_2", "activity_3", "activity_4", "activity_5", 
                   "activity_6", "activity_7", "activity_8", "activity_9", "activity_10", 
                   "activity_11", "activity_12", "activity_13", "activity_14", "activity_15", 
                   "activity_16", "activity_17", "activity_18", "activity_19", "activity_20", 
                   "activity_21", 
                   "productivity_1", "productivity_2", "productivity_3", "productivity_4", "productivity_5", 
                   "productivity_6", "productivity_7", "productivity_8", "productivity_9", "productivity_10", 
                   "productivity_11", "productivity_12", "productivity_13", "productivity_14", "productivity_15", 
                   "productivity_16", 
                   "va_1", "va_2", "va_3", "va_4", "va_5", 
                   "va_6", "va_7", "va_8", "va_9", "va_10", 
                   "va_11", "va_12", 
                   "invest_1", "invest_2", "invest_3", "invest_4", "invest_5", 
                   "invest_6", "invest_7", "invest_8", 
                   "ebitda_1", "ebitda_2", "ebitda_3", "ebitda_4", "ebitda_5", 
                   "ebitda_6",
                   "fiscalyearmonth", "title", "name.job", "carrier1.job", "carrier2.job", "carrier3.job", "fiscalyearmonth2", 
                   "title2", "name.job2", "carrier1.job2", "carrier2.job2", "carrier3.job2", "total_asset", "capital", "common_stock", "earnings", "sales", 
                   "total_auditor", "total_director", "total_accounting", "total_is", "total_fund", "total_others", 
                   "iacs_auditor", "iacs_director", "iacs_accounting", "iacs_is", "iacs_fund", "iacs_others",
                   "certi_auditor", "certi_director", "certi_accounting", "certi_is", "certi_fund", "certi_others",
                   "average_auditor", "average_director", "average_accounting", "average_is", "average_fund", "average_others",
                   "iacs_report", "auditor_report", "ex_auditor_report")


# 새로운 변수를 kospi 데이터에 할당
names(full) <- new_col_names

# 변수 필터
#  "fiscalyearmonth", "title", "name.job", "carrier1.job", "carrier2.job", "carrier3.job", "fiscalyearmonth2", 
#  "title2", "name.job2", "carrier2.job2", "carrier3.job2", "total_asset", "capital", "common_stock", "earnings", "sales", 
#  "total_auditor", "total_director", "total_accounting", "total_is", "total_fund", "total_others", 
#  "iacs_auditor", "iacs_director", "iacs_accounting", "iacs_is", "iacs_fund", "iacs_others",
#  "certi_auditor", "certi_director", "certi_accounting", "certi_is", "certi_fund", "certi_others",
#  "average_auditor", "average_director", "average_accounting", "average_is", "average_fund", "average_others",
#  "iacs_report", "auditor_report", "ex_auditor_report")

full_val_selected <- select(full, # full에서 아래의 변수들을 제거
                                    
                            # 기업 일반 정보
                            -index, -name, -market_code, -fiscal_year, -fiscal_month,
                            -auditor, -internal_audit, -external_audit,
                            
                            # 2007년 이전에 해당 변수
                            -growth_5, 
                            -profit_3, -profit_7, -profit_10, -profit_13, -profit_16, -profit_17, -profit_45, 
                            -productivity_4,
                            
                            # 중복 변수
                            # 부가가치(백만원)...137 / productivity_1 = # 부가가치(백만원)...153 / va_1
                            # 종업원1인당 부가가치(백만원)...138 / productivity_2 = # 종업원1인당 부가가치(백만원)...160 / va_8
                            # 총자본투자효율...146 / productivity_10 = # 총자본투자효율...161 / va_9
                            # 기계투자효율...148 / productivity_12 = # 기계투자효율...162 / va_10
                            # 부가가치율...149 / productivity_13 = # 부가가치율...163 / va_11
                            -productivity_1, -productivity_2,  -productivity_10, -productivity_12, -productivity_13,
                            -fiscalyearmonth, -title, -name.job, -carrier1.job, -carrier2.job, -carrier3.job, -fiscalyearmonth2, -title2, 
                            -name.job2, -carrier1.job2, -carrier2.job2, -carrier3.job2, -common_stock,
                            
                            # 산업분류 제거
                            -industry
)

# missing value imputation 접근으로 감 -> mice 패키지에서 제공하는 multiple imputation

names_df <- data.frame(new_col_names, raw_full_col_names)

table(full_val_selected$total_others)

library(mice)
full_val_selected_imputed_cart <- mice(full_val_selected, method = "cart", seed = 1030)
imputed_full_cart <- complete(full_val_selected_imputed_cart, 1)
sum(is.na(imputed_full_cart))
imputed_full_cart[is.na(imputed_full_cart)] <- 0
sum(is.na(imputed_full_cart))

table(imputed_full_cart$total_others)

## within()
imputed_full_cart <- within(imputed_full_cart, {
    total_others_dummy = character(0) 
    total_others_dummy[total_others < 10] = "0" 
    total_others_dummy[total_others >=10 & total_others < 20 ] = "1" 
    total_others_dummy[total_others >=20 & total_others < 30 ] = "2" 
    total_others_dummy[total_others >=30 & total_others < 40 ] = "3" 
    total_others_dummy[total_others >=40 & total_others < 50 ] = "4" 
    total_others_dummy[total_others >=50 & total_others < 60 ] = "5" 
    total_others_dummy[total_others >=60 & total_others < 70 ] = "6" 
    total_others_dummy[total_others >=70 & total_others < 80 ] = "7" 
    total_others_dummy[total_others >=80 & total_others < 90 ] = "8" 
    total_others_dummy[total_others >=90 ] = "9" 
    total_others_dummy = factor(total_others_dummy, level = c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9"))
    })

table(imputed_full_cart$total_others_dummy)

glimpse(imputed_full_cart)

imputed_full <- select(imputed_full_cart, -total_others)
glimpse(imputed_full)

sum(is.na(imputed_full_df))

# 상하위 10개씩 상관계수 그리기
imputed_full_df <- as.data.frame(imputed_full)

imputed_full_df[, c(2, 1)] <- imputed_full_df[, c(1, 2)]
names(imputed_full_df)[2] <- "market"
names(imputed_full_df)[1] <- "target"


t <- numeric()
df <- numeric()
p <- numeric()
cor <- numeric()
for (i in 1:186) {
  tmp_cor_test <- cor.test(as.numeric(imputed_full_df[, i]), as.numeric(imputed_full_df$target))
  t[i] <- tmp_cor_test[1][[1]][[1]]
  df[i] <- tmp_cor_test[2][[1]][[1]]
  p[i] <- tmp_cor_test[3][[1]]
  cor[i] <- tmp_cor_test[4][[1]][[1]]
}
cor_test <- data.frame(t, df, p, cor)
cor_test$var <- colnames(imputed_full_df[1:186])
cor_test_sorted <- cor_test %>%
  arrange(desc(cor))
cor_test_highlow <- cor_test_sorted[c(1:11, 170:186), ]
cor_test_highlow %>% 
  ggplot(aes(reorder(var, cor), cor)) +
  geom_point() +
  coord_flip()

cor_test_sorted
cor_test_highlow

library(ROCR)
################################################################################

n <- nrow(imputed_full)
idx <- 1:n
idx_train <- sample(idx, n * 0.60)
idx <- setdiff(idx, idx_train)
idx_validate <- sample(idx, n * 0.20)
idx_test <- setdiff(idx, idx_validate)
train <- imputed_full[idx_train, ]
validation <- imputed_full[idx_validate, ]
test <- imputed_full[idx_test, ]

################################################################################

# logistic regression
forensic_glm <- glm(target ~ ., data = train, family = binomial)
yhat_glm_validation <- predict(forensic_glm, newdata = validation, type = 'response')
pred_glm_validation <- prediction(yhat_glm_validation, as.numeric(as.character(validation$target)))
perf_glm_validation <- performance(pred_glm_validation, measure = 'tpr', x.measure = 'fpr')
performance(pred_glm_validation, "auc")@y.values[[1]]

yhat_glm_test <- predict(forensic_glm, newdata = test, type = 'response')
pred_glm_test <- prediction(yhat_glm_test, as.numeric(as.character(test$target)))
perf_glm_test <- performance(pred_glm_test, measure = 'tpr', x.measure = 'fpr')
performance(pred_glm_test, "auc")@y.values[[1]]

# tree model - cart
library(rpart)
forensic_cart <- rpart(target ~ ., data = train, method = "class")
yhat_cart_validation <- predict(forensic_cart, validation, type = "prob")[, 2]
pred_cart_validation <- prediction(yhat_cart_validation, as.numeric(as.character(validation$target)))
perf_cart_validation <- performance(pred_cart_validation, measure = 'tpr', x.measure = 'fpr')
performance(pred_cart_validation, "auc")@y.values[[1]]

yhat_cart_test <- predict(forensic_cart, newdata = test, type = "prob")[, 2]
pred_cart_test <- prediction(yhat_cart_test, as.numeric(as.character(test$target)))
perf_cart_test <- performance(pred_cart_test, measure = 'tpr', x.measure = 'fpr')
performance(pred_cart_test, "auc")@y.values[[1]]

# randomForest
library(randomForest)
forensic_rf <- randomForest(target ~ ., data = train)
yhat_rf_validation <- predict(forensic_rf, newdata = validation)
pred_rf_validation <- prediction(yhat_rf_validation, as.numeric(as.character(validation$target)))
perf_rf_validation <- performance(pred_rf_validation, measure = 'tpr', x.measure = 'fpr')
performance(pred_rf_validation, "auc")@y.values[[1]]

yhat_rf_test <- predict(forensic_rf, newdata = test)
pred_rf_test <- prediction(yhat_rf_test, as.numeric(as.character(test$target)))
perf_rf_test <- performance(pred_rf_test, measure = 'tpr', x.measure = 'fpr')
performance(pred_rf_test, "auc")@y.values[[1]]

library(gbm)
forensic_gbm <- gbm(as.numeric(as.character(target)) ~ . , data = train, distribution = "bernoulli", n.trees = 50000, cv.folds = 3, verbose = T)
best_tier <- gbm.perf(forensic_gbm, method = "cv")
yhat_gbm <- predict(forensic_gbm, n.trees = best_tier, newdata = validation, type = 'response')
pred_gbm <- prediction(yhat_gbm, as.numeric(as.character(validation$target)))
perf_gbm <- performance(pred_gbm, measure = 'tpr', x.measure = 'fpr')
performance(pred_gbm, "auc")@y.values[[1]]

yhat_gbm_test <- predict(forensic_gbm, n.trees = best_tier, newdata = test, type = 'response')
pred_gbm_test <- prediction(yhat_gbm_test, as.numeric(as.character(test$target)))
perf_gbm_test <- performance(pred_gbm_test, measure = 'tpr', x.measure = 'fpr')
performance(pred_gbm_test, "auc")@y.values[[1]]

# xgboost
library(xgboost)

label <- imputed_full$target
imputed_full_xgboot <- select(imputed_full, -target)
imputed_full_xgboot$total_others_dummy <- as.numeric(imputed_full_xgboot$total_others_dummy)

n <- nrow(imputed_full_xgboot)
idx_train_xgboost <- sample(n, n * 0.80)
train_xgboost <- as.matrix(imputed_full_xgboot[idx_train_xgboost, ])
train_label_xgboost <- label[idx_train_xgboost]
test_xgboost <- as.matrix(imputed_full_xgboot[-idx_train_xgboost, ])
test_label_xgboost <- label[-idx_train_xgboost]

xgb.train <- xgb.DMatrix(data = train_xgboost, label = train_label_xgboost)
xgb.test <- xgb.DMatrix(data = test_xgboost, label = test_label_xgboost)

num_class <- length(levels(label))
num_class

params <- list(
  booster = "gbtree",
  eta = 0.001,
  max_depth = 5,
  gamma = 3,
  subsample = 0.8,
  colsample_bytree = 1,
  objective = "binary:logistic",
  eval_metric = "auc",
  num_class = num_class
)

forensic_xgb <- xgb.train(
  params = params,
  data = xgb.train,
  nrounds = 10000,
  nthreads = 6,
  early_stopping_rounds = 10,
  watchlist = list(val1 = xgb.train, val2 = xgb.test),
  verbose = 0
)

# xgb.pred <- predict(xgb.fit, test_xgboost)
# xgb.pred <- ifelse(xgb.pred > 0.5, 1, 0)
# perf_gbm_test <- performance(pred_gbm_test, measure = 'tpr', x.measure = 'fpr')

yhat_xgb_test <- predict(forensic_xgb, newdata = test_xgboost)
pred_xgb_test <- prediction(yhat_xgb_test, as.numeric(as.character(test$target)))
perf_xgb_test <- performance(pred_xgb_test, measure = 'tpr', x.measure = 'fpr')
performance(pred_gbm_test, "auc")@y.values[[1]]


library(caret)
library(e1071)
confusionMatrix(as.factor(xgb.pred), as.factor(test_label_xgboost))

# ROC 곡선 그리기
par(mfrow = c(2, 2))

plot(perf_glm_test, main = 'ROC Curve for Logistic Model', lty = 2)
abline(0, 1)

plot(perf_cart_test, main = 'ROC Curve for Tree Model', lty = 2)
abline(0, 1)

plot(perf_rf_test, main = 'ROC Curve for Random Forest Model', lty = 2)
abline(0, 1)

plot(perf_gbm_test, main = 'ROC Curve for GBM Model', lty = 2)
abline(0, 1)

plot(perf_xgb_test, main = 'ROC Curve for XGBoost Model', lty = 1)
abline(0, 1)

par(mfrow = c(1,1))

par(mfrow = c(2, 2))

plot(perf_glm_validation, main = 'ROC Curve for Logistic Model', lty = 1)
plot(perf_glm_test, add = TRUE, lty = 2)
abline(0, 1)
legend('bottomright', inset = 0.1, legend = c("Validation ROC", "Test ROC"), lty = c(1, 2), lwd = 2)

plot(perf_cart_validation, main = 'ROC Curve for Tree Model', lty = 1)
plot(perf_cart_test, add = TRUE, lty = 2)
abline(0, 1)
legend('bottomright', inset = 0.1, legend = c("Validation ROC", "Test ROC"), lty = c(1, 2), lwd = 2)

plot(perf_rf_validation, main = 'ROC Curve for Random Forest Model', lty = 1)
plot(perf_rf_test, add = TRUE, lty = 2)
abline(0, 1)
legend('bottomright', inset = 0.1, legend = c("Validation ROC", "Test ROC"), lty = c(1, 2), lwd = 2)

plot(perf_gbm, main = 'ROC Curve for Gradient Boosting Model', lty = 1)
plot(perf_gbm_test, add = TRUE, lty = 2)
abline(0, 1)
legend('bottomright', inset = 0.1, legend = c("Validation ROC", "Test ROC"), lty = c(1, 2), lwd = 2)

par(mfrow = c(1,1))

#######################################################################################################################
#######################################################################################################################
#######################################################################################################################


# ROC 차이 검정 - https://www.r-bloggers.com/statistical-assessments-of-auc/
library(pROC)

# set.seed(2019)
# REFERENCE:
# A METHOD OF COMPARING THE AREAS UNDER RECEIVER OPERATING CHARACTERISTIC CURVES DERIVED FROM THE SAME CASES
# HANLEY JA, MCNEIL BJ (1983)
# pROC::roc.test(roc1, roc2, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
# D = 1.7164, boot.n = 500, boot.stratified = 1, p-value = 0.0861

# REFERENCE:
# COMPARING THE AREAS UNDER TWO OR MORE CORRELATED RECEIVER OPERATING CHARACTERISTIC CURVES: A NONPARAMETRIC APPROACH
# DELONG ER, DELONG DM, CLARKE-PEARSON DL (1988)
# pROC::roc.test(roc1, roc2, method = "delong", paired = T)
# Z = 1.7713, p-value = 0.0765

# REFERENCE
# A DISTRIBUTION-FREE PROCEDURE FOR COMPARING RECEIVER OPERATING CHARACTERISTIC CURVES FROM A PAIRED EXPERIMENT
# VENKATRAMAN ES, BEGG CB (1996)
# pROC::roc.test(roc1, roc2, method = "venkatraman", boot.n = 500, progress = "none", paired = T)
# E = 277560, boot.n = 500, p-value = 0.074

set.seed(1000)
roc_glm_test <- pROC::roc(response = test$target, predictor = yhat_glm_test)
roc_cart_test <- pROC::roc(response = test$target, predictor = yhat_cart_test)
roc_rf_test <- pROC::roc(response = test$target, predictor = yhat_rf_test)
roc_gbm_test <- pROC::roc(response = test$target, predictor = yhat_gbm_test)
roc_xgb_test <- pROC::roc(response = test$target, predictor = yhat_xgb_test)

set.seed(1000)
roc_test_glm_cart <- pROC::roc.test(roc_glm_test, roc_cart_test, method = "bootstrap", boot.n = 5000, progress = "none", paired = T)
roc_test_glm_cart

set.seed(1000)
roc_test_glm_rf <- pROC::roc.test(roc_glm_test, roc_rf_test, method = "bootstrap", boot.n = 5000, progress = "none", paired = T)
roc_test_glm_rf

set.seed(1000)
roc_test_glm_gbm <- pROC::roc.test(roc_glm_test, roc_gbm_test, method = "bootstrap", boot.n = 5000, progress = "none", paired = T)
roc_test_glm_gbm

set.seed(1000)
roc_test_glm_xgb <- pROC::roc.test(roc_glm_test, roc_xgb_test, method = "bootstrap", boot.n = 5000, progress = "none", paired = T)
roc_test_glm_xgb

#######################################################################################################################

set.seed(1000)
roc_test_cart_rf <- pROC::roc.test(roc_cart_test, roc_rf_test, method = "bootstrap", boot.n = 5000, progress = "none", paired = T)
roc_test_cart_rf

set.seed(1000)
roc_test_cart_gbm <- pROC::roc.test(roc_cart_test, roc_gbm_test, method = "bootstrap", boot.n = 5000, progress = "none", paired = T)
roc_test_cart_gbm

set.seed(1000)
roc_test_cart_xgb <- pROC::roc.test(roc_rf_test, roc_xgb_test, method = "bootstrap", boot.n = 5000, progress = "none", paired = T)
roc_test_cart_xgb

#######################################################################################################################

set.seed(1000)
roc_test_rf_gbm <- pROC::roc.test(roc_rf_test, roc_gbm_test, method = "bootstrap", boot.n = 5000, progress = "none", paired = T)
roc_test_rf_gbm

set.seed(1000)
roc_test_rf_xgb <- pROC::roc.test(roc_rf_test, roc_xgb_test, method = "bootstrap", boot.n = 5000, progress = "none", paired = T)
roc_test_rf_xgb

set.seed(1000)
roc_test_gbm_xgb <- pROC::roc.test(roc_gbm_test, roc_xgb_test, method = "bootstrap", boot.n = 5000, progress = "none", paired = T)
roc_test_gbm_xgb

#######################################################################################################################
#######################################################################################################################
#######################################################################################################################

library(caret)
# varImp의 레퍼런스 https://www.rdocumentation.org/packages/caret/versions/6.0-84/topics/varImp

# gbm의 method 인자 설명 
# The function used to compute the relative influence. relative.influence is
# the default and is the same as that described in Friedman (2001). The other current (and experimental) choice is permutation.test.gbm. This method randomly permutes each predictor variable at a time and computes the associated
# reduction in predictive performance. This is similar to the variable importance
# measures Breiman uses for random forests, but gbm currently computes using
# the entire training dataset (not the out-of-bag observations).

summary(forensic_glm)
varImp(forensic_glm)

summary(forensic_cart)
varImp(forensic_cart)

summary(forensic_rf)
varImp(forensic_rf)

summary(forensic_gbm)

xgb.importance(model = xgb.fit)


#######################################################################################################################
#######################################################################################################################
#######################################################################################################################

library(SHAPforxgboost)

shap_values <- shap.values(xgb_model = forensic_xgb, X_train = train_xgboost)
shap_values$mean_shap_score

shap_data <- shap_values$shap_score
shap_data[, BIAS := shap_values$BIAS0]
pred_mod <- predict(forensic_xgb, train_xgboost, ntreelimit = params$nrounds)
shap_data[, `:=`(rowSum = round(rowSums(shap_data),6), pred_mod = round(pred_mod,6))]
table(shap_data[1:20,])

shap_long <- shap.prep(xgb_model = forensic_xgb, X_train = train_xgboost)
shap_long <- shap.prep(shap_contrib = shap_values$shap_score, X_train = train_xgboost)


shap.plot.summary(shap_long)
shap.plot.summary(shap_long, x_bound  = 1.2, dilute = 10)
