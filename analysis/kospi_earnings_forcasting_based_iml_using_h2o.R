# 데이터 importing

# 기업 선택 조건:
# 결산기 변경사 불포함, 상장일 이전 자료 포함, 
# 기업명/거래소코드/회계년도 포함 169개 변수(재무비율 변수는 166개)

# 추출일: 2020/05/29
# - kospi 957개사
# -- mnft / fiscal year: 12 end
# -- 보고서 제출 기간: 현재 기준
# -- 상장일: 1956/01/01 ~ 2020/05/26
# -- 폐지사 포함: 1956/01/01 ~ 2020/05/26
# -- 소속부: 일반/관리 모두 포함
# -- 외부감사기관: 전체
# - kosdaq: 1877개사
# -- mnft / fiscal year: 12 end
# -- 보고서 제출 기간: 현재 기준
# -- 상장일: 1956/01/01 ~ 2020/05/26
# -- 폐지사 포함: 1956/01/01 ~ 2020/05/26
# -- 소속부: 일반/관리 모두 포함
# -- 외부감사기관: 전체

library(tidyverse)
library(readxl)

raw_fi_ratio_kospi_1981 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1981.xlsx")
raw_fi_ratio_kospi_1982 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1982.xlsx")
raw_fi_ratio_kospi_1983 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1983.xlsx")
raw_fi_ratio_kospi_1984 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1984.xlsx")
raw_fi_ratio_kospi_1985 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1985.xlsx")
raw_fi_ratio_kospi_1986 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1986.xlsx")
raw_fi_ratio_kospi_1987 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1987.xlsx")
raw_fi_ratio_kospi_1988 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1988.xlsx")
raw_fi_ratio_kospi_1989 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1988.xlsx")
raw_fi_ratio_kospi_1990 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1990.xlsx")
raw_fi_ratio_kospi_1991 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1991.xlsx")
raw_fi_ratio_kospi_1992 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1992.xlsx")
raw_fi_ratio_kospi_1993 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1993.xlsx")
raw_fi_ratio_kospi_1994 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1994.xlsx")
raw_fi_ratio_kospi_1995 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1995.xlsx")
raw_fi_ratio_kospi_1996 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1996.xlsx")
raw_fi_ratio_kospi_1997 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1997.xlsx")
raw_fi_ratio_kospi_1998 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1998.xlsx")
raw_fi_ratio_kospi_1999 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_1999.xlsx")
raw_fi_ratio_kospi_2000 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2000.xlsx")
raw_fi_ratio_kospi_2001 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2001.xlsx")
raw_fi_ratio_kospi_2002 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2002.xlsx")
raw_fi_ratio_kospi_2003 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2003.xlsx")
raw_fi_ratio_kospi_2004 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2004.xlsx")
raw_fi_ratio_kospi_2005 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2005.xlsx")
raw_fi_ratio_kospi_2006 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2006.xlsx")
raw_fi_ratio_kospi_2007 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2007.xlsx")
raw_fi_ratio_kospi_2008 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2008.xlsx")
raw_fi_ratio_kospi_2009 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2009.xlsx")
raw_fi_ratio_kospi_2010 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2010.xlsx")
raw_fi_ratio_kospi_2011 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2011.xlsx")
raw_fi_ratio_kospi_2012 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2012.xlsx")
raw_fi_ratio_kospi_2013 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2013.xlsx")
raw_fi_ratio_kospi_2014 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2014.xlsx")
raw_fi_ratio_kospi_2015 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2015.xlsx")
raw_fi_ratio_kospi_2016 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2016.xlsx")
raw_fi_ratio_kospi_2017 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2017.xlsx")
raw_fi_ratio_kospi_2018 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2018.xlsx")
raw_fi_ratio_kospi_2019 <- read_excel("~/projects/financial_information_analysis/data/financial_ratios/financial_ratio_kospi_mnft_20200529_2019.xlsx")

# 원래 열 이름을 별도로 저장해 둠
raw_col_names <- names(raw_fi_ratio_kospi_2019)

# 열 이름을 새롭게 정의
new_col_names <- c(
  "name", "market_corp_code", "fiscal_year",
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
  "ebitda_6")

# 새로운 변수를 kospi 데이터에 할당
for(i in 1:39){
  tmp <- paste0("names(raw_fi_ratio_kospi_", i+1980, ") <- new_col_names")
  eval(parse(text = tmp))
}

# test data와 train data의 구성
# test data
# 0(2019) if EPS(2019) - EPS(2018) - (EPS(2019) - EPS(2015))/4 < 0
# 1(2019) if EPS(2019) - EPS(2018) - (EPS(2019) - EPS(2015))/4 > 0
# dEPS는 정의에 따라 계산한 값
# dEPS(t) = EPS(t) - EPS(t-1) - AVE_EPS(t) 
# AVE_EPS(t) = {(EPS(t) - EPS(t-1)) + (EPS(t-1) - EPS(t-2)) + (EPS(t-2) - EPS(t-3)) + (EPS(t-3) - EPS(t-4))} / 4 
#            = (EPS(t) - EPS(t-4)) / 4
# DEPS는 0과 1로 재정의한 값
# DEPS(t) = test$DEPS <- ifelse(test$dEPS > 0, 1, 0)

# 실제 test data 계산
# EPS(t)는 raw_col_names에서 61번째에 위치함. 그리고 이 값의 변경된 변수명은 "profit_44"임.
test_kospi <- raw_fi_ratio_kospi_2018
test_kospi$dEPS <- raw_fi_ratio_kospi_2019$profit_44 - raw_fi_ratio_kospi_2018$profit_44 - (raw_fi_ratio_kospi_2019$profit_44 - raw_fi_ratio_kospi_2015$profit_44)/4
test_kospi$DEPS <- ifelse(test_kospi$dEPS > 0, 1, 0)

# 중복 변수를 찾기 위해 원래의 변수명과 새 변수명 벡터를 하나의 tibble로 합쳐서 눈의로 확인할 수 있도록 함. 
# 할려면 원래 변수명에서 숫자가 포함된 위치를 찾아 중복 변수를 찾을 수도 있겠지만, 시간이 없을 땐 노가다..
col_name_df <- data.frame(raw_col_names, new_col_names)

# test data 변수 선택 기준: 
test_kospi_val_selected <- select(test_kospi, # test_kospi에서 아래의 변수들을 제거
                                  -name, -market_corp_code, -fiscal_year, # 기업 일반 정보
                                  -growth_5, -profit_3, -profit_7, -profit_10, -profit_13, -profit_16, -profit_17, -profit_45, -productivity_4, # 2007년 이전 발생
                                  -productivity_1, -productivity_2, -productivity_10, -productivity_12, -productivity_13, -va_1, -va_8, -va_9, -va_10, -va_11, # 중복 변수
                                  -dEPS)

test_kospi_val_selected_na <- test_kospi_val_selected[complete.cases(test_kospi_val_selected), ] # test_kospi_val_selected에서 na가 있는 행 제거

# train data 계산 - 목표 변수
# Y = 0(2018) if EPS(2018) - EPS(2017) - (EPS(2018) - EPS(2014))/4 < 0
# Y = 1(2018) if EPS(2018) - EPS(2017) - (EPS(2018) - EPS(2014))/4 > 0
# X = FINANCIALRATIOS(2016)

for(i in 1:34){
  dEPS <- get(paste0("raw_fi_ratio_kospi_", i+1984))[, 61] - get(paste0("raw_fi_ratio_kospi_", i+1983))[, 61] - (get(paste0("raw_fi_ratio_kospi_", i+1984))[, 61] - get(paste0("raw_fi_ratio_kospi_", i+1980))[, 61]/4)
  DEPS <- ifelse(dEPS > 0, 1, 0)
  assign(paste0("train_kospi_", i+1984), tibble(get(paste0("raw_fi_ratio_kospi_", i+1983)), DEPS))
}

# merge train data 
train_kospi_full <- bind_rows(train_kospi_1985, train_kospi_1986, train_kospi_1987, train_kospi_1988, train_kospi_1989,
                              train_kospi_1990, train_kospi_1991, train_kospi_1992, train_kospi_1993, train_kospi_1994,
                              train_kospi_1995, train_kospi_1996, train_kospi_1997, train_kospi_1998, train_kospi_1999, 
                              train_kospi_2000, train_kospi_2001, train_kospi_2002, train_kospi_2003, train_kospi_2004,
                              train_kospi_2005, train_kospi_2006, train_kospi_2007, train_kospi_2008, train_kospi_2009, 
                              train_kospi_2010, train_kospi_2011, train_kospi_2012, train_kospi_2013, train_kospi_2014,
                              train_kospi_2015, train_kospi_2016, train_kospi_2017, train_kospi_2018)

train_kospi_val_selected <- select(train_kospi_full, # train_kospi_full에서 아래의 변수들을 제거
                                   -name, -market_corp_code, -fiscal_year, # 기업 일반 정보
                                   -growth_5, -profit_3, -profit_7, -profit_10, -profit_13, -profit_16, -profit_17, -profit_45, -productivity_4, # 2007년 이전 발생
                                   -productivity_1, -productivity_2, -productivity_10, -productivity_12, -productivity_13, -va_1, -va_8, -va_9, -va_10, -va_11) # 중복 변수

train_kospi_val_selected_na <- train_kospi_val_selected[complete.cases(train_kospi_val_selected), ] # 각 행에 저장된 모든 값이 NA가 아닐 때만 TRUE

# 상하위 10개씩 상관계수 그리기
train_kospi_val_selected_na_df <- as.data.frame(train_kospi_val_selected_na)
t <- numeric()
df <- numeric()
p <- numeric()
cor <- numeric()

for (i in 1:147) {
  tmp_cor_test <- cor.test(train_kospi_val_selected_na_df[, i], train_kospi_val_selected_na_df$DEPS)
  t[i] <- tmp_cor_test[1][[1]][[1]]
  df[i] <- tmp_cor_test[2][[1]][[1]]
  p[i] <- tmp_cor_test[3][[1]]
  cor[i] <- tmp_cor_test[4][[1]][[1]]
}
cor_test <- data.frame(t, df, p, cor)
cor_test$var <- colnames(train_kospi_val_selected_na[1:147])
cor_test_sorted <- cor_test %>%
  arrange(desc(cor))
cor_test_highlow <- cor_test_sorted[c(1:10, 138:147), ]
cor_test_highlow %>% 
  ggplot(aes(reorder(var, cor), cor)) +
  geom_point() +
  coord_flip()

# 모델 학습
library(h2o)
h2o.init()

y <- "DEPS"
x <- setdiff(names(train_kospi_val_selected_na), y)

train_kospi_val_selected_na[, y] <- as.factor(train_kospi_val_selected_na[, y])
test_kospi_val_selected_na[, y] <- as.factor(test_kospi_val_selected_na[, y])

train_kospi_h2o <- as.h2o(train_kospi_val_selected_na, "train_kospi_h2o")
test_kospi_h2o <- as.h2o(test_kospi_val_selected_na, "test_kospi_h2o")

glm_model <- h2o.glm(x = x, y = y, training_frame = train_kospi_h2o, model_id = "glm_model", nfolds = 10, family = "binomial")

gbm_model <- h2o.gbm(x = x, y = y, training_frame = train_kospi_h2o, model_id = "gbm_model", nfolds = 10, ntrees = 100)

xgb_model <- h2o.xgboost(x = x, y = y, training_frame = train_kospi_h2o, validation_frame = test_kospi_h2o, booster = "dart", normalize_type = "tree", nfolds = 10, seed = 1234)

perf_glm <- h2o.performance(glm_model, test_kospi_h2o)
perf_glm

perf_gbm <- h2o.performance(gbm_model, test_kospi_h2o)
perf_gbm

perf_xgb <- h2o.performance(xgb_model, test_kospi_h2o)
perf_xgb

library(lime)
explainer <- lime(x = train_kospi_val_selected_na, model = glm_model)
explainations <- explain(x = test_kospi_val_selected, 
                         explainer = explainer,
                         n_permutations = 5000,
                         feature_select = "auto",
                         n_features = 10,
                         labels = NULL,
                         n_labels = 1)

library(lime)
explainer <- lime(x = train_kospi_val_selected_na, model = gbm_model)
explainations <- explain(x = test_kospi_val_selected, 
                         explainer = explainer,
                         n_permutations = 5000,
                         feature_select = "auto",
                         n_features = 10,
                         labels = NULL,
                         n_labels = 1)

library(lime)
explainer <- lime(x = train_kospi_val_selected_na, model = xgb_model)
explainations <- explain(x = test_kospi_val_selected, 
                         explainer = explainer,
                         n_permutations = 5000,
                         feature_select = "auto",
                         n_features = 10,
                         labels = NULL,
                         n_labels = 1)