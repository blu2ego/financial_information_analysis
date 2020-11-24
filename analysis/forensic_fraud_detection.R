################################################################################
### fraud detection using sentiment analysis and interpretable machine learning
################################################################################
library(tidyverse)
library(caret)
library(DALEX)
library(shapper)

full <- readRDS("~/projects/accounting/data-raw/audit_review.rds")

# full에서 변수들을 제거
full_val_selected <- select(full,
                         
                            # 기업 일반 정보
                            
                            -index, -name, -market_code, -fiscal_year, 
                            -fiscal_month, -auditor, -internal_audit, 
                            -external_audit, -unique,
                            
                            # 2007년 이전에 해당 변수
                            
                            -growth_5, 
                            -profit_3, -profit_7, -profit_10, -profit_13, 
                            -profit_16, -profit_17, -profit_45, 
                            -productivity_4,
                            
                            # 중복 변수
                            # 부가가치...137 / productivity_1 = 
                            # 부가가치...153 / va_1
                            
                            # 종업원1인당 부가가치...138 / productivity_2 = 
                            # 종업원1인당 부가가치...160 / va_8
                            
                            # 총자본투자효율...146 / productivity_10 = 
                            # 총자본투자효율...161 / va_9
                            
                            # 기계투자효율...148 / productivity_12 = 
                            # 기계투자효율...162 / va_10
                            
                            # 부가가치율...149 / productivity_13 = 
                            # 부가가치율...163 / va_11
                            
                            -productivity_1, -productivity_2, -productivity_10, 
                            -productivity_12, -productivity_13, 
                            -fiscalyearmonth, -title, -name.job, -carrier1.job, 
                            -carrier2.job, -carrier3.job, -fiscalyearmonth2, 
                            -title2, -name.job2, -carrier1.job2, -carrier2.job2, 
                            -carrier3.job2, -common_stock,
                            
                            # 산업분류 제거
                            
                            -industry,
                            
                            # 텍스트와 관련 정보 제거
                            -report_txt, -senti_score, -senti_magnitude
                            )


################################################################################
### missing value imputation -> mice 패키지에서 제공하는 multiple imputation
################################################################################

library(mice)
full_val_selected_imputed <- mice(full_val_selected, 
                                  method = "cart", seed = 1030)

##### imputataion 된 데이터셋을 선택 - 첫 번째
imputed_full <- complete(full_val_selected_imputed, 1)

##### mice로도 imputation 되지 않는 NA들을 0으로 정리함
imputed_full[is.na(imputed_full)] <- 0

sum(is.na(imputed_full))
################################################################################
### 상관관계를 분석
################################################################################

t <- numeric()
df <- numeric()
p <- numeric()
cor <- numeric()
ln_idx <- length(names(imputed_full))
for (i in 1:ln_idx) {
  tmp_cor_test <- cor.test(as.numeric(imputed_full[, i]), 
                           as.numeric(imputed_full$target))
  t[i] <- tmp_cor_test[1][[1]][[1]]
  df[i] <- tmp_cor_test[2][[1]][[1]]
  p[i] <- tmp_cor_test[3][[1]]
  cor[i] <- tmp_cor_test[4][[1]][[1]]
}
cor_test <- data.frame(t, df, p, cor)
cor_test$var <- colnames(imputed_full[1:ln_idx])
cor_test_sorted <- cor_test %>%
  arrange(desc(cor))

cor_test_sorted
################################################################################
### 상관계수 확인시 이상 변수 확인 => 추가 변수 제거
################################################################################

imputed <- select(imputed_full, -certi_is, -iacs_report)

################################################################################
##### 훈련/실험 데이터 생성: training / testing - 모든 변수 포함 (all)
################################################################################

index_train <- createDataPartition(imputed$target, p = .95, list = F)
training <- imputed[index_train, ]
training$target <- as.factor(training$target)
levels(training$target) <- c("unfound", "found")
testing  <- imputed[-index_train, ]
testing$target <- as.factor(testing$target)
levels(testing$target) <- c("unfound", "found")

################################################################################
##### 모형 학습
################################################################################

library(caret)
library(ROCR)

fitControl <- trainControl(method = "cv", 
                           number = 10, 
                           classProbs = T, 
                           savePredictions = T, 
                           allowParallel = T)

#### logistic
fit_glm <- train(target ~ ., 
                 data = training, 
                 method = "glm", 
                 trControl = fitControl)

yhat_glm <- predict(fit_glm, newdata = testing, type = "raw")
yhat_glm_test <- predict(fit_glm, newdata = testing, type = 'raw')
pred_glm_test <- prediction(as.numeric(yhat_glm_test), 
                            as.numeric(testing$target))
perf_glm_test <- performance(pred_glm_test, 
                             measure = 'tpr', x.measure = 'fpr')

##### tree
fit_tr <- train(target ~ .,
                data = training, 
                method = "rpart", 
                trControl = fitControl)

yhat_tr <- predict(fit_tr, newdata = testing, type = "raw")
yhat_tr_test <- predict(fit_tr, newdata = testing, type = 'raw')
pred_tr_test <- prediction(as.numeric(yhat_tr_test), 
                           as.numeric(testing$target))
perf_tr_test <- performance(pred_tr_test, 
                            measure = 'tpr', x.measure = 'fpr')

##### random forest
fit_rf <- train(target ~ ., 
                data = training, 
                method = "rf", 
                trControl = fitControl)

yhat_rf <- predict(fit_rf, newdata = testing, type = "raw")
yhat_rf_test <- predict(fit_rf, newdata = testing, type = 'raw')
pred_rf_test <- prediction(as.numeric(yhat_rf_test), 
                           as.numeric(testing$target))
perf_rf_test <- performance(pred_rf_test, 
                            measure = 'tpr', x.measure = 'fpr')

##### xgboost
fit_xgb <- train(target ~ ., 
                   data = training, 
                   method = "xgbTree", 
                   trControl = fitControl)

yhat_xgb <- predict(fit_xgb, newdata = testing, type = "raw")
yhat_xgb_test <- predict(fit_xgb, newdata = testing, type = 'raw')
pred_xgb_test <- prediction(as.numeric(yhat_xgb_test), 
                              as.numeric(testing$target))
perf_xgb_test <- performance(pred_xgb_test, 
                               measure = 'tpr', x.measure = 'fpr')


################################################################################
##### 모든 학습된 모형의 AUC 취합
################################################################################

performance(pred_glm_test, "auc")@y.values[[1]]; 
performance(pred_tr_test, "auc")@y.values[[1]]; 
performance(pred_rf_test, "auc")@y.values[[1]]; 
performance(pred_xgb_test, "auc")@y.values[[1]]

################################################################################
##### ROC curves
################################################################################

par(mfrow = c(2, 2))

plot(perf_glm_test, main = 'ROC Curve for Logistic Model', lty = 2)
abline(0, 1)
legend('bottomright', inset = 0.1, legend = c("Test ROC"), lty = 2)


plot(perf_tr_test, main = 'ROC Curve for Tree Model', lty = 2)
abline(0, 1)
legend('bottomright', inset = 0.1, legend = c("Test ROC"), lty = 2)

plot(perf_rf_test, main = 'ROC Curve for Random Forest Model', lty = 2)
abline(0, 1)
legend('bottomright', inset = 0.1, legend = c("Test ROC"), lty = 2)

plot(perf_xgb_test, main = 'ROC Curve for XGBoost Model', lty = 2)
abline(0, 1)
legend('bottomright', inset = 0.1, legend = c("Test ROC"), lty = 2)

par(mfrow = c(1, 1))

################################################################################
##### variabel importance using caret::varImp()
################################################################################

varImp(fit_glm); varImp(fit_tr); varImp(fit_rf); varImp(fit_xgb)

##### print importance of full variable
varImp(fit_glm)$importance
varImp(fit_xgb)$importance

################################################################################
##### statistical test of ROC difference
################################################################################

library(pROC)

set.seed(1000)
roc_glm_test <- pROC::roc(response = as.numeric(testing$target), 
                          predictor = as.numeric(yhat_glm_test))
roc_tr_test <- pROC::roc(response = as.numeric(testing$target), 
                         predictor = as.numeric(yhat_tr_test))
roc_rf_test <- pROC::roc(response = as.numeric(testing$target), 
                         predictor = as.numeric(yhat_rf_test))
roc_xgb_test <- pROC::roc(response = as.numeric(testing$target), 
                          predictor = as.numeric(yhat_xgb_test))

################################################################################

set.seed(1000)
roc_test_glm_tr <- pROC::roc.test(roc_glm_test, roc_tr_test, 
                                  method = "bootstrap", boot.n = 10000, 
                                  progress = "none", paired = T)
roc_test_glm_tr

set.seed(1000)
roc_test_glm_rf <- pROC::roc.test(roc_glm_test, roc_rf_test, 
                                  method = "bootstrap", boot.n = 10000, 
                                  progress = "none", paired = T)
roc_test_glm_rf

set.seed(1000)
roc_test_glm_xgb <- pROC::roc.test(roc_glm_test, roc_xgb_test, 
                                   method = "bootstrap", boot.n = 10000, 
                                   progress = "none", paired = T)
roc_test_glm_xgb

################################################################################

set.seed(1000)
roc_test_tr_rf <- pROC::roc.test(roc_tr_test, roc_rf_test, 
                                 method = "bootstrap", boot.n = 10000, 
                                 progress = "none", paired = T)
roc_test_tr_rf

set.seed(1000)
roc_test_tr_xgb <- pROC::roc.test(roc_tr_test, roc_xgb_test, 
                                  method = "bootstrap", boot.n = 10000, 
                                  progress = "none", paired = T)
roc_test_tr_xgb

################################################################################

set.seed(1000)
roc_test_rf_xgb <- pROC::roc.test(roc_rf_test, roc_xgb_test, 
                                  method = "bootstrap", boot.n = 10000, 
                                  progress = "none", paired = T)
roc_test_rf_xgb

################################################################################
##### IML: SHAP
################################################################################

library(DALEX)
library(shapper)
shapper::install_shap()

exp_glm <- DALEX::explain(fit_glm, data = training[, -2], 
                          y = training$target == "found", 
                          label = "glm")

################################################################################
which(testing$target == "found")

# [1] 3 16 18

which(training$target == "found")
#  [1]   2   4   9  13  15  17  19  25  27  29  32  38  43  47  52  57  67  72  
# 76  80  85  89  94  98 104 109 114 117 126 130 133 135 142 147 151 156 159 161
# [39] 166 170 175 179 184 187 189 192 197 202 207 212 216 221 224 229 232 235 
# 238 242 247 252 256 261 264 268 271 277 281 286 289 291 294 305 308 313 316 320
# [77] 324 328 340 345 350

new_obs <- testing[3, -2]
indv_found <- shap(exp_glm, new_observation = new_obs)
indv_found_selected <- subset(indv_found, 
                              `_vname_` == "total_auditor" |
                                `_vname_` == "total_director" |
                                `_vname_` == "total_accounting" |
                                `_vname_` == "total_is" |
                                `_vname_` == "total_fund" |
                                `_vname_` == "total_others" |
                                `_vname_` == "iacs_auditor" | 
                                `_vname_` == "iacs_director" |
                                `_vname_` == "iacs_accounting" |
                                `_vname_` == "iacs_is" |
                                `_vname_` == "iacs_fund" |
                                `_vname_` == "iacs_others" |
                                `_vname_` == "certi_auditor" | 
                                `_vname_` == "certi_director" |
                                `_vname_` == "certi_accounting" |
                                `_vname_` == "certi_is" |
                                `_vname_` == "certi_fund" |
                                `_vname_` == "certi_others" |
                                `_vname_` == "average_auditor" | 
                                `_vname_` == "average_director" |
                                `_vname_` == "average_accounting" |
                                `_vname_` == "average_is" |
                                `_vname_` == "average_fund" |
                                `_vname_` == "average_others" |
                                `_vname_` == "auditor_report" |
                                `_vname_` == "ex_average_others" |
                                `_vname_` == "sa"
)
plot(indv_found_selected)

idx_testing_found <- which(testing$target == "found")
idx_testing_unfound <- which(testing$target == "unfound")

idx_training_found <- which(training$target == "found")
idx_training_unfound <- which(training$target == "unfound")

aggre_sa <- data.frame()
for (i in 1:length(idx_testing_found)) {
  itf <- idx_testing_found[i]
  new_obs <- testing[itf, -2]
  shap_testing_found <- shap(exp_glm, new_observation = new_obs)
  aggre_sa[i, 1] <- shap_testing_found[shap_testing_found$`_vname_` == "sa", "_attribution_"]
}

for (i in 1:length(idx_testing_unfound)) {
  ituf <- idx_testing_unfound[i]
  new_obs <- testing[ituf, -2]
  shap_testing_unfound <- shap(exp_glm, new_observation = new_obs)
  aggre_sa[i, 2] <- shap_testing_unfound[shap_testing_unfound$`_vname_` == "sa", "_attribution_"]
}

for (i in 1:length(idx_training_found)) {
  itrf <- idx_training_found[i]
  new_obs <- training[itrf, -2]
  shap_training_found <- shap(exp_glm, new_observation = new_obs)
  aggre_sa[i, 3] <- shap_training_found[shap_training_found$`_vname_` == "sa", "_attribution_"]
}

for (i in 1:length(idx_training_unfound)) {
  itruf <- idx_training_unfound[i]
  new_obs <- training[itruf, -2]
  shap_training_unfound <- shap(exp_glm, new_observation = new_obs)
  aggre_sa[i, 4] <- shap_training_unfound[shap_training_unfound$`_vname_` == "sa", "_attribution_"]
}


save.image("analysis/forensic.RData")