# 기업 조건: 12월말 / 제조업 / KOSPI / 1981 ~ 2016 / 상장일 이전 자료 포함
# 기업 수: 711개사

# 재무비율 데이터 불러오기

library(readxl)
library(ROCR)
library(tidyverse)

raw_fi_ratio_2018 <- read_xlsx("~/projects/financial_information_analysis/data/fs/fr/financial_ratio_2018.xlsx", col_names = T, na = "")
raw_fi_ratio_2017 <- read_xlsx("~/projects/financial_information_analysis/data/fs/fr/financial_ratio_2017.xlsx", col_names = T, na = "")
raw_fi_ratio_2016 <- read_xlsx("~/projects/financial_information_analysis/data/fs/fr/financial_ratio_2016.xlsx", col_names = T, na = "")
raw_fi_ratio_2015 <- read_xlsx("~/projects/financial_information_analysis/data/fs/fr/financial_ratio_2015.xlsx", col_names = T, na = "")
raw_fi_ratio_2014 <- read_xlsx("~/projects/financial_information_analysis/data/fs/fr/financial_ratio_2014.xlsx", col_names = T, na = "")
raw_fi_ratio_2013 <- read_xlsx("~/projects/financial_information_analysis/data/fs/fr/financial_ratio_2013.xlsx", col_names = T, na = "")
raw_fi_ratio_2012 <- read_xlsx("~/projects/financial_information_analysis/data/fs/fr/financial_ratio_2012.xlsx", col_names = T, na = "")
raw_fi_ratio_2011 <- read_xlsx("~/projects/financial_information_analysis/data/fs/fr/financial_ratio_2011.xlsx", col_names = T, na = "")
raw_fi_ratio_2010 <- read_xlsx("~/projects/financial_information_analysis/data/fs/fr/financial_ratio_2010.xlsx", col_names = T, na = "")
raw_fi_ratio_2009 <- read_xlsx("~/projects/financial_information_analysis/data/fs/fr/financial_ratio_2009.xlsx", col_names = T, na = "")

# 원래 열 이름을 별도로 저장해 둠
raw_col_names <- names(raw_fi_ratio_2018)

# 열 이름을 새롭게 정의
names(raw_fi_ratio_2018) <- c(
  "name", "code", "year", 
  "growth_1", "growth_2", "growth_3", "growth_4", "growth_5", "growth_6", "growth_7", "growth_8", "growth_9", "growth_10", "growth_11", "growth_12", "growth_13", 
  "growth_14",
  "profit_1", "profit_2", "profit_3", "profit_4", "profit_5", "profit_6", "profit_7", "profit_8", "profit_9", "profit_10", "profit_11", "profit_12", "profit_13", 
  "profit_14",
  "profit_15", "profit_16", "profit_17", "profit_18", "profit_19", "profit_20", "profit_21", "profit_22", "profit_23", "profit_24", "profit_25", "profit_26", "profit_27",
  "profit_28", "profit_29", "profit_30", "profit_31", "profit_32", "profit_33", "profit_34", "profit_35", "profit_36", "profit_37", "profit_38", "profit_39", "profit_40",
  "profit_41", "profit_42", "profit_43", "profit_44", "profit_45", "profit_46", "profit_47", "profit_48", "profit_49", "profit_50", 
  "safety_1", "safety_2", "safety_3", "safety_4", "safety_5", "safety_6", "safety_7", "safety_8", "safety_9", "safety_10", "safety_11", "safety_12", 
  "safety_13", "safety_14", "safety_15", "safety_16", "safety_17", "safety_18", "safety_19", "safety_20", "safety_21", "safety_22", "safety_23", 
  "safety_24", "safety_25", "safety_26", "safety_27", "safety_28", "safety_29", "safety_30", "safety_31", "safety_32", "safety_33", "safety_34", 
  "safety_35", "safety_36", "safety_37", "safety_38", "safety_39", 
  "activity_1", "activity_2", "activity_3", "activity_4", "activity_5", "activity_6", "activity_7", "activity_8", "activity_9", "activity_10", "activity_11", "activity_12",
  "activity_13", "activity_14", "activity_15", "activity_16", "activity_17", "activity_18", "activity_19", "activity_20", "activity_21", 
  "productivity_1", "productivity_2", "productivity_3", "productivity_4", "productivity_5", "productivity_6", "productivity_7", "productivity_8", "productivity_9", 
  "productivity_10", "productivity_11", "productivity_12", "productivity_13", "productivity_14", "productivity_15", "productivity_16", 
  "va_1", "va_2", "va_3", "va_4", "va_5", "va_6", "va_7", "va_8", "va_9", "va_10", "va_11", "va_12", 
  "invest_1", "invest_2", "invest_3", "invest_4", "invest_5", "invest_6", "invest_7", "invest_8", 
  "ebitda_1", "ebitda_2", "ebitda_3", "ebitda_4", "ebitda_5", "ebitda_6",
  "earnings", "num_common_stock", "total_asset", "total_capital", "cash_divident"
)

names(raw_fi_ratio_2017) <- c(
  "name", "code", "year", 
  "growth_1", "growth_2", "growth_3", "growth_4", "growth_5", "growth_6", "growth_7", "growth_8", "growth_9", "growth_10", "growth_11", "growth_12", "growth_13", 
  "growth_14",
  "profit_1", "profit_2", "profit_3", "profit_4", "profit_5", "profit_6", "profit_7", "profit_8", "profit_9", "profit_10", "profit_11", "profit_12", "profit_13", 
  "profit_14",
  "profit_15", "profit_16", "profit_17", "profit_18", "profit_19", "profit_20", "profit_21", "profit_22", "profit_23", "profit_24", "profit_25", "profit_26", "profit_27",
  "profit_28", "profit_29", "profit_30", "profit_31", "profit_32", "profit_33", "profit_34", "profit_35", "profit_36", "profit_37", "profit_38", "profit_39", "profit_40",
  "profit_41", "profit_42", "profit_43", "profit_44", "profit_45", "profit_46", "profit_47", "profit_48", "profit_49", "profit_50", 
  "safety_1", "safety_2", "safety_3", "safety_4", "safety_5", "safety_6", "safety_7", "safety_8", "safety_9", "safety_10", "safety_11", "safety_12", 
  "safety_13", "safety_14", "safety_15", "safety_16", "safety_17", "safety_18", "safety_19", "safety_20", "safety_21", "safety_22", "safety_23", 
  "safety_24", "safety_25", "safety_26", "safety_27", "safety_28", "safety_29", "safety_30", "safety_31", "safety_32", "safety_33", "safety_34", 
  "safety_35", "safety_36", "safety_37", "safety_38", "safety_39", 
  "activity_1", "activity_2", "activity_3", "activity_4", "activity_5", "activity_6", "activity_7", "activity_8", "activity_9", "activity_10", "activity_11", "activity_12",
  "activity_13", "activity_14", "activity_15", "activity_16", "activity_17", "activity_18", "activity_19", "activity_20", "activity_21", 
  "productivity_1", "productivity_2", "productivity_3", "productivity_4", "productivity_5", "productivity_6", "productivity_7", "productivity_8", "productivity_9", 
  "productivity_10", "productivity_11", "productivity_12", "productivity_13", "productivity_14", "productivity_15", "productivity_16", 
  "va_1", "va_2", "va_3", "va_4", "va_5", "va_6", "va_7", "va_8", "va_9", "va_10", "va_11", "va_12", 
  "invest_1", "invest_2", "invest_3", "invest_4", "invest_5", "invest_6", "invest_7", "invest_8", 
  "ebitda_1", "ebitda_2", "ebitda_3", "ebitda_4", "ebitda_5", "ebitda_6",
  "earnings", "num_common_stock", "total_asset", "total_capital", "cash_divident"
)

names(raw_fi_ratio_2016) <- c(
  "name", "code", "year", 
  "growth_1", "growth_2", "growth_3", "growth_4", "growth_5", "growth_6", "growth_7", "growth_8", "growth_9", "growth_10", "growth_11", "growth_12", "growth_13", 
  "growth_14",
  "profit_1", "profit_2", "profit_3", "profit_4", "profit_5", "profit_6", "profit_7", "profit_8", "profit_9", "profit_10", "profit_11", "profit_12", "profit_13", 
  "profit_14",
  "profit_15", "profit_16", "profit_17", "profit_18", "profit_19", "profit_20", "profit_21", "profit_22", "profit_23", "profit_24", "profit_25", "profit_26", "profit_27",
  "profit_28", "profit_29", "profit_30", "profit_31", "profit_32", "profit_33", "profit_34", "profit_35", "profit_36", "profit_37", "profit_38", "profit_39", "profit_40",
  "profit_41", "profit_42", "profit_43", "profit_44", "profit_45", "profit_46", "profit_47", "profit_48", "profit_49", "profit_50", 
  "safety_1", "safety_2", "safety_3", "safety_4", "safety_5", "safety_6", "safety_7", "safety_8", "safety_9", "safety_10", "safety_11", "safety_12", 
  "safety_13", "safety_14", "safety_15", "safety_16", "safety_17", "safety_18", "safety_19", "safety_20", "safety_21", "safety_22", "safety_23", 
  "safety_24", "safety_25", "safety_26", "safety_27", "safety_28", "safety_29", "safety_30", "safety_31", "safety_32", "safety_33", "safety_34", 
  "safety_35", "safety_36", "safety_37", "safety_38", "safety_39", 
  "activity_1", "activity_2", "activity_3", "activity_4", "activity_5", "activity_6", "activity_7", "activity_8", "activity_9", "activity_10", "activity_11", "activity_12",
  "activity_13", "activity_14", "activity_15", "activity_16", "activity_17", "activity_18", "activity_19", "activity_20", "activity_21", 
  "productivity_1", "productivity_2", "productivity_3", "productivity_4", "productivity_5", "productivity_6", "productivity_7", "productivity_8", "productivity_9", 
  "productivity_10", "productivity_11", "productivity_12", "productivity_13", "productivity_14", "productivity_15", "productivity_16", 
  "va_1", "va_2", "va_3", "va_4", "va_5", "va_6", "va_7", "va_8", "va_9", "va_10", "va_11", "va_12", 
  "invest_1", "invest_2", "invest_3", "invest_4", "invest_5", "invest_6", "invest_7", "invest_8", 
  "ebitda_1", "ebitda_2", "ebitda_3", "ebitda_4", "ebitda_5", "ebitda_6",
  "earnings", "num_common_stock", "total_asset", "total_capital", "cash_divident"
)

names(raw_fi_ratio_2015) <- c(
  "name", "code", "year", 
  "growth_1", "growth_2", "growth_3", "growth_4", "growth_5", "growth_6", "growth_7", "growth_8", "growth_9", "growth_10", "growth_11", "growth_12", "growth_13", 
  "growth_14",
  "profit_1", "profit_2", "profit_3", "profit_4", "profit_5", "profit_6", "profit_7", "profit_8", "profit_9", "profit_10", "profit_11", "profit_12", "profit_13", 
  "profit_14",
  "profit_15", "profit_16", "profit_17", "profit_18", "profit_19", "profit_20", "profit_21", "profit_22", "profit_23", "profit_24", "profit_25", "profit_26", "profit_27",
  "profit_28", "profit_29", "profit_30", "profit_31", "profit_32", "profit_33", "profit_34", "profit_35", "profit_36", "profit_37", "profit_38", "profit_39", "profit_40",
  "profit_41", "profit_42", "profit_43", "profit_44", "profit_45", "profit_46", "profit_47", "profit_48", "profit_49", "profit_50", 
  "safety_1", "safety_2", "safety_3", "safety_4", "safety_5", "safety_6", "safety_7", "safety_8", "safety_9", "safety_10", "safety_11", "safety_12", 
  "safety_13", "safety_14", "safety_15", "safety_16", "safety_17", "safety_18", "safety_19", "safety_20", "safety_21", "safety_22", "safety_23", 
  "safety_24", "safety_25", "safety_26", "safety_27", "safety_28", "safety_29", "safety_30", "safety_31", "safety_32", "safety_33", "safety_34", 
  "safety_35", "safety_36", "safety_37", "safety_38", "safety_39", 
  "activity_1", "activity_2", "activity_3", "activity_4", "activity_5", "activity_6", "activity_7", "activity_8", "activity_9", "activity_10", "activity_11", "activity_12",
  "activity_13", "activity_14", "activity_15", "activity_16", "activity_17", "activity_18", "activity_19", "activity_20", "activity_21", 
  "productivity_1", "productivity_2", "productivity_3", "productivity_4", "productivity_5", "productivity_6", "productivity_7", "productivity_8", "productivity_9", 
  "productivity_10", "productivity_11", "productivity_12", "productivity_13", "productivity_14", "productivity_15", "productivity_16", 
  "va_1", "va_2", "va_3", "va_4", "va_5", "va_6", "va_7", "va_8", "va_9", "va_10", "va_11", "va_12", 
  "invest_1", "invest_2", "invest_3", "invest_4", "invest_5", "invest_6", "invest_7", "invest_8", 
  "ebitda_1", "ebitda_2", "ebitda_3", "ebitda_4", "ebitda_5", "ebitda_6",
  "earnings", "num_common_stock", "total_asset", "total_capital", "cash_divident"
)

names(raw_fi_ratio_2014) <- c(
  "name", "code", "year", 
  "growth_1", "growth_2", "growth_3", "growth_4", "growth_5", "growth_6", "growth_7", "growth_8", "growth_9", "growth_10", "growth_11", "growth_12", "growth_13", 
  "growth_14",
  "profit_1", "profit_2", "profit_3", "profit_4", "profit_5", "profit_6", "profit_7", "profit_8", "profit_9", "profit_10", "profit_11", "profit_12", "profit_13", 
  "profit_14",
  "profit_15", "profit_16", "profit_17", "profit_18", "profit_19", "profit_20", "profit_21", "profit_22", "profit_23", "profit_24", "profit_25", "profit_26", "profit_27",
  "profit_28", "profit_29", "profit_30", "profit_31", "profit_32", "profit_33", "profit_34", "profit_35", "profit_36", "profit_37", "profit_38", "profit_39", "profit_40",
  "profit_41", "profit_42", "profit_43", "profit_44", "profit_45", "profit_46", "profit_47", "profit_48", "profit_49", "profit_50", 
  "safety_1", "safety_2", "safety_3", "safety_4", "safety_5", "safety_6", "safety_7", "safety_8", "safety_9", "safety_10", "safety_11", "safety_12", 
  "safety_13", "safety_14", "safety_15", "safety_16", "safety_17", "safety_18", "safety_19", "safety_20", "safety_21", "safety_22", "safety_23", 
  "safety_24", "safety_25", "safety_26", "safety_27", "safety_28", "safety_29", "safety_30", "safety_31", "safety_32", "safety_33", "safety_34", 
  "safety_35", "safety_36", "safety_37", "safety_38", "safety_39", 
  "activity_1", "activity_2", "activity_3", "activity_4", "activity_5", "activity_6", "activity_7", "activity_8", "activity_9", "activity_10", "activity_11", "activity_12",
  "activity_13", "activity_14", "activity_15", "activity_16", "activity_17", "activity_18", "activity_19", "activity_20", "activity_21", 
  "productivity_1", "productivity_2", "productivity_3", "productivity_4", "productivity_5", "productivity_6", "productivity_7", "productivity_8", "productivity_9", 
  "productivity_10", "productivity_11", "productivity_12", "productivity_13", "productivity_14", "productivity_15", "productivity_16", 
  "va_1", "va_2", "va_3", "va_4", "va_5", "va_6", "va_7", "va_8", "va_9", "va_10", "va_11", "va_12", 
  "invest_1", "invest_2", "invest_3", "invest_4", "invest_5", "invest_6", "invest_7", "invest_8", 
  "ebitda_1", "ebitda_2", "ebitda_3", "ebitda_4", "ebitda_5", "ebitda_6",
  "earnings", "num_common_stock", "total_asset", "total_capital", "cash_divident"
)

names(raw_fi_ratio_2013) <- c(
  "name", "code", "year", 
  "growth_1", "growth_2", "growth_3", "growth_4", "growth_5", "growth_6", "growth_7", "growth_8", "growth_9", "growth_10", "growth_11", "growth_12", "growth_13", 
  "growth_14",
  "profit_1", "profit_2", "profit_3", "profit_4", "profit_5", "profit_6", "profit_7", "profit_8", "profit_9", "profit_10", "profit_11", "profit_12", "profit_13", 
  "profit_14",
  "profit_15", "profit_16", "profit_17", "profit_18", "profit_19", "profit_20", "profit_21", "profit_22", "profit_23", "profit_24", "profit_25", "profit_26", "profit_27",
  "profit_28", "profit_29", "profit_30", "profit_31", "profit_32", "profit_33", "profit_34", "profit_35", "profit_36", "profit_37", "profit_38", "profit_39", "profit_40",
  "profit_41", "profit_42", "profit_43", "profit_44", "profit_45", "profit_46", "profit_47", "profit_48", "profit_49", "profit_50", 
  "safety_1", "safety_2", "safety_3", "safety_4", "safety_5", "safety_6", "safety_7", "safety_8", "safety_9", "safety_10", "safety_11", "safety_12", 
  "safety_13", "safety_14", "safety_15", "safety_16", "safety_17", "safety_18", "safety_19", "safety_20", "safety_21", "safety_22", "safety_23", 
  "safety_24", "safety_25", "safety_26", "safety_27", "safety_28", "safety_29", "safety_30", "safety_31", "safety_32", "safety_33", "safety_34", 
  "safety_35", "safety_36", "safety_37", "safety_38", "safety_39", 
  "activity_1", "activity_2", "activity_3", "activity_4", "activity_5", "activity_6", "activity_7", "activity_8", "activity_9", "activity_10", "activity_11", "activity_12",
  "activity_13", "activity_14", "activity_15", "activity_16", "activity_17", "activity_18", "activity_19", "activity_20", "activity_21", 
  "productivity_1", "productivity_2", "productivity_3", "productivity_4", "productivity_5", "productivity_6", "productivity_7", "productivity_8", "productivity_9", 
  "productivity_10", "productivity_11", "productivity_12", "productivity_13", "productivity_14", "productivity_15", "productivity_16", 
  "va_1", "va_2", "va_3", "va_4", "va_5", "va_6", "va_7", "va_8", "va_9", "va_10", "va_11", "va_12", 
  "invest_1", "invest_2", "invest_3", "invest_4", "invest_5", "invest_6", "invest_7", "invest_8", 
  "ebitda_1", "ebitda_2", "ebitda_3", "ebitda_4", "ebitda_5", "ebitda_6",
  "earnings", "num_common_stock", "total_asset", "total_capital", "cash_divident"
)

names(raw_fi_ratio_2012) <- c(
  "name", "code", "year", 
  "growth_1", "growth_2", "growth_3", "growth_4", "growth_5", "growth_6", "growth_7", "growth_8", "growth_9", "growth_10", "growth_11", "growth_12", "growth_13", 
  "growth_14",
  "profit_1", "profit_2", "profit_3", "profit_4", "profit_5", "profit_6", "profit_7", "profit_8", "profit_9", "profit_10", "profit_11", "profit_12", "profit_13", 
  "profit_14",
  "profit_15", "profit_16", "profit_17", "profit_18", "profit_19", "profit_20", "profit_21", "profit_22", "profit_23", "profit_24", "profit_25", "profit_26", "profit_27",
  "profit_28", "profit_29", "profit_30", "profit_31", "profit_32", "profit_33", "profit_34", "profit_35", "profit_36", "profit_37", "profit_38", "profit_39", "profit_40",
  "profit_41", "profit_42", "profit_43", "profit_44", "profit_45", "profit_46", "profit_47", "profit_48", "profit_49", "profit_50", 
  "safety_1", "safety_2", "safety_3", "safety_4", "safety_5", "safety_6", "safety_7", "safety_8", "safety_9", "safety_10", "safety_11", "safety_12", 
  "safety_13", "safety_14", "safety_15", "safety_16", "safety_17", "safety_18", "safety_19", "safety_20", "safety_21", "safety_22", "safety_23", 
  "safety_24", "safety_25", "safety_26", "safety_27", "safety_28", "safety_29", "safety_30", "safety_31", "safety_32", "safety_33", "safety_34", 
  "safety_35", "safety_36", "safety_37", "safety_38", "safety_39", 
  "activity_1", "activity_2", "activity_3", "activity_4", "activity_5", "activity_6", "activity_7", "activity_8", "activity_9", "activity_10", "activity_11", "activity_12",
  "activity_13", "activity_14", "activity_15", "activity_16", "activity_17", "activity_18", "activity_19", "activity_20", "activity_21", 
  "productivity_1", "productivity_2", "productivity_3", "productivity_4", "productivity_5", "productivity_6", "productivity_7", "productivity_8", "productivity_9", 
  "productivity_10", "productivity_11", "productivity_12", "productivity_13", "productivity_14", "productivity_15", "productivity_16", 
  "va_1", "va_2", "va_3", "va_4", "va_5", "va_6", "va_7", "va_8", "va_9", "va_10", "va_11", "va_12", 
  "invest_1", "invest_2", "invest_3", "invest_4", "invest_5", "invest_6", "invest_7", "invest_8", 
  "ebitda_1", "ebitda_2", "ebitda_3", "ebitda_4", "ebitda_5", "ebitda_6",
  "earnings", "num_common_stock", "total_asset", "total_capital", "cash_divident"
)

names(raw_fi_ratio_2011) <- c(
  "name", "code", "year", 
  "growth_1", "growth_2", "growth_3", "growth_4", "growth_5", "growth_6", "growth_7", "growth_8", "growth_9", "growth_10", "growth_11", "growth_12", "growth_13", 
  "growth_14",
  "profit_1", "profit_2", "profit_3", "profit_4", "profit_5", "profit_6", "profit_7", "profit_8", "profit_9", "profit_10", "profit_11", "profit_12", "profit_13", 
  "profit_14",
  "profit_15", "profit_16", "profit_17", "profit_18", "profit_19", "profit_20", "profit_21", "profit_22", "profit_23", "profit_24", "profit_25", "profit_26", "profit_27",
  "profit_28", "profit_29", "profit_30", "profit_31", "profit_32", "profit_33", "profit_34", "profit_35", "profit_36", "profit_37", "profit_38", "profit_39", "profit_40",
  "profit_41", "profit_42", "profit_43", "profit_44", "profit_45", "profit_46", "profit_47", "profit_48", "profit_49", "profit_50", 
  "safety_1", "safety_2", "safety_3", "safety_4", "safety_5", "safety_6", "safety_7", "safety_8", "safety_9", "safety_10", "safety_11", "safety_12", 
  "safety_13", "safety_14", "safety_15", "safety_16", "safety_17", "safety_18", "safety_19", "safety_20", "safety_21", "safety_22", "safety_23", 
  "safety_24", "safety_25", "safety_26", "safety_27", "safety_28", "safety_29", "safety_30", "safety_31", "safety_32", "safety_33", "safety_34", 
  "safety_35", "safety_36", "safety_37", "safety_38", "safety_39", 
  "activity_1", "activity_2", "activity_3", "activity_4", "activity_5", "activity_6", "activity_7", "activity_8", "activity_9", "activity_10", "activity_11", "activity_12",
  "activity_13", "activity_14", "activity_15", "activity_16", "activity_17", "activity_18", "activity_19", "activity_20", "activity_21", 
  "productivity_1", "productivity_2", "productivity_3", "productivity_4", "productivity_5", "productivity_6", "productivity_7", "productivity_8", "productivity_9", 
  "productivity_10", "productivity_11", "productivity_12", "productivity_13", "productivity_14", "productivity_15", "productivity_16", 
  "va_1", "va_2", "va_3", "va_4", "va_5", "va_6", "va_7", "va_8", "va_9", "va_10", "va_11", "va_12", 
  "invest_1", "invest_2", "invest_3", "invest_4", "invest_5", "invest_6", "invest_7", "invest_8", 
  "ebitda_1", "ebitda_2", "ebitda_3", "ebitda_4", "ebitda_5", "ebitda_6",
  "earnings", "num_common_stock", "total_asset", "total_capital", "cash_divident"
)

names(raw_fi_ratio_2010) <- c(
  "name", "code", "year", 
  "growth_1", "growth_2", "growth_3", "growth_4", "growth_5", "growth_6", "growth_7", "growth_8", "growth_9", "growth_10", "growth_11", "growth_12", "growth_13", 
  "growth_14",
  "profit_1", "profit_2", "profit_3", "profit_4", "profit_5", "profit_6", "profit_7", "profit_8", "profit_9", "profit_10", "profit_11", "profit_12", "profit_13", 
  "profit_14",
  "profit_15", "profit_16", "profit_17", "profit_18", "profit_19", "profit_20", "profit_21", "profit_22", "profit_23", "profit_24", "profit_25", "profit_26", "profit_27",
  "profit_28", "profit_29", "profit_30", "profit_31", "profit_32", "profit_33", "profit_34", "profit_35", "profit_36", "profit_37", "profit_38", "profit_39", "profit_40",
  "profit_41", "profit_42", "profit_43", "profit_44", "profit_45", "profit_46", "profit_47", "profit_48", "profit_49", "profit_50", 
  "safety_1", "safety_2", "safety_3", "safety_4", "safety_5", "safety_6", "safety_7", "safety_8", "safety_9", "safety_10", "safety_11", "safety_12", 
  "safety_13", "safety_14", "safety_15", "safety_16", "safety_17", "safety_18", "safety_19", "safety_20", "safety_21", "safety_22", "safety_23", 
  "safety_24", "safety_25", "safety_26", "safety_27", "safety_28", "safety_29", "safety_30", "safety_31", "safety_32", "safety_33", "safety_34", 
  "safety_35", "safety_36", "safety_37", "safety_38", "safety_39", 
  "activity_1", "activity_2", "activity_3", "activity_4", "activity_5", "activity_6", "activity_7", "activity_8", "activity_9", "activity_10", "activity_11", "activity_12",
  "activity_13", "activity_14", "activity_15", "activity_16", "activity_17", "activity_18", "activity_19", "activity_20", "activity_21", 
  "productivity_1", "productivity_2", "productivity_3", "productivity_4", "productivity_5", "productivity_6", "productivity_7", "productivity_8", "productivity_9", 
  "productivity_10", "productivity_11", "productivity_12", "productivity_13", "productivity_14", "productivity_15", "productivity_16", 
  "va_1", "va_2", "va_3", "va_4", "va_5", "va_6", "va_7", "va_8", "va_9", "va_10", "va_11", "va_12", 
  "invest_1", "invest_2", "invest_3", "invest_4", "invest_5", "invest_6", "invest_7", "invest_8", 
  "ebitda_1", "ebitda_2", "ebitda_3", "ebitda_4", "ebitda_5", "ebitda_6",
  "earnings", "num_common_stock", "total_asset", "total_capital", "cash_divident"
)

names(raw_fi_ratio_2009) <- c(
  "name", "code", "year", 
  "growth_1", "growth_2", "growth_3", "growth_4", "growth_5", "growth_6", "growth_7", "growth_8", "growth_9", "growth_10", "growth_11", "growth_12", "growth_13", 
  "growth_14",
  "profit_1", "profit_2", "profit_3", "profit_4", "profit_5", "profit_6", "profit_7", "profit_8", "profit_9", "profit_10", "profit_11", "profit_12", "profit_13", 
  "profit_14",
  "profit_15", "profit_16", "profit_17", "profit_18", "profit_19", "profit_20", "profit_21", "profit_22", "profit_23", "profit_24", "profit_25", "profit_26", "profit_27",
  "profit_28", "profit_29", "profit_30", "profit_31", "profit_32", "profit_33", "profit_34", "profit_35", "profit_36", "profit_37", "profit_38", "profit_39", "profit_40",
  "profit_41", "profit_42", "profit_43", "profit_44", "profit_45", "profit_46", "profit_47", "profit_48", "profit_49", "profit_50", 
  "safety_1", "safety_2", "safety_3", "safety_4", "safety_5", "safety_6", "safety_7", "safety_8", "safety_9", "safety_10", "safety_11", "safety_12", 
  "safety_13", "safety_14", "safety_15", "safety_16", "safety_17", "safety_18", "safety_19", "safety_20", "safety_21", "safety_22", "safety_23", 
  "safety_24", "safety_25", "safety_26", "safety_27", "safety_28", "safety_29", "safety_30", "safety_31", "safety_32", "safety_33", "safety_34", 
  "safety_35", "safety_36", "safety_37", "safety_38", "safety_39", 
  "activity_1", "activity_2", "activity_3", "activity_4", "activity_5", "activity_6", "activity_7", "activity_8", "activity_9", "activity_10", "activity_11", "activity_12",
  "activity_13", "activity_14", "activity_15", "activity_16", "activity_17", "activity_18", "activity_19", "activity_20", "activity_21", 
  "productivity_1", "productivity_2", "productivity_3", "productivity_4", "productivity_5", "productivity_6", "productivity_7", "productivity_8", "productivity_9", 
  "productivity_10", "productivity_11", "productivity_12", "productivity_13", "productivity_14", "productivity_15", "productivity_16", 
  "va_1", "va_2", "va_3", "va_4", "va_5", "va_6", "va_7", "va_8", "va_9", "va_10", "va_11", "va_12", 
  "invest_1", "invest_2", "invest_3", "invest_4", "invest_5", "invest_6", "invest_7", "invest_8", 
  "ebitda_1", "ebitda_2", "ebitda_3", "ebitda_4", "ebitda_5", "ebitda_6",
  "earnings", "num_common_stock", "total_asset", "total_capital", "cash_divident"
)

# test data와 train data의 구성

# test data
# 0(2018) if EPS(2018) - EPS(2017) - (EPS(2018) - EPS(2014))/4 < 0
# 1(2018) if EPS(2018) - EPS(2017) - (EPS(2018) - EPS(2014))/4 > 0

# 계산해야 할 변수는 
# dEPS(t)_1 = EPS(t) - EPS(t-1)
# dEPS(t)_2 = EPS(t) - EPS(t-1) - AVE_EPS(t) 
# AVE_EPS(t) = {(EPS(t) - EPS(t-1)) + (EPS(t-1) - EPS(t-2)) + (EPS(t-2) - EPS(t-3)) + (EPS(t-3) - EPS(t-4))} / 4 = (EPS(t) - EPS(t-4)) / 4

# 실제 test data 계산
# EPS(t)는 raw_col_names에서 61번째에 위치함. 그리고 이 값의 변경된 변수명은 "profit_44"임.

# dEPS는 계산값이며, DEPS는 0과 1로 재정의한 값
test <- raw_fi_ratio_2017
test$dEPS <- raw_fi_ratio_2018$profit_44 - raw_fi_ratio_2017$profit_44 - (raw_fi_ratio_2018$profit_44 - raw_fi_ratio_2014$profit_44)/4
test$DEPS <- ifelse(test$dEPS > 0, 1, 0)
test$FDEPS <- as.factor(test$DEPS)

test_sel_val <- select(test, -growth_5, -profit_3, -profit_7, -profit_10, -profit_13, -profit_16, -profit_17, -profit_45, 
                       -productivity_1, -productivity_4, -productivity_10, -productivity_12, -productivity_13, -safety_14,
                       -earnings, -num_common_stock, -total_asset, -total_capital, -cash_divident, -dEPS, -name, -code, -year, -DEPS)

test_na <- test_sel_val[complete.cases(test_sel_val), ]

# train data

# Y = 0(2017) if EPS(2017) - EPS(2016) - (EPS(2017) - EPS(2013))/4 < 0
# Y = 1(2017) if EPS(2017) - EPS(2016) - (EPS(2017) - EPS(2013))/4 > 0
# X = FINANCIALRATIO(2016)

# train data 계산 - 목표 변수

# 2017년
train_fi_ratio_2017 <- raw_fi_ratio_2016
train_fi_ratio_2017$dEPS <- raw_fi_ratio_2017$profit_44 - raw_fi_ratio_2016$profit_44 - (raw_fi_ratio_2017$profit_44 - raw_fi_ratio_2013$profit_44)/4
train_fi_ratio_2017$DEPS <- ifelse(train_fi_ratio_2017$dEPS > 0, 1, 0)
train_fi_ratio_2017$FDEPS <- as.factor(train_fi_ratio_2017$DEPS)

train_2017_sel_val <- select(train_fi_ratio_2017, -growth_5, -profit_3, -profit_7, -profit_10, -profit_13, -profit_16, -profit_17, -profit_45, 
                             -productivity_1, -productivity_4, -productivity_10, -productivity_12, -productivity_13, -safety_14,
                             -earnings, -num_common_stock, -total_asset, -total_capital, -cash_divident, -dEPS, -name, -code, -year, -DEPS)

train_2017_na <- train_2017_sel_val[complete.cases(train_2017_sel_val), ]

# 2016년
train_fi_ratio_2016 <- raw_fi_ratio_2015
train_fi_ratio_2016$dEPS <- raw_fi_ratio_2016$profit_44 - raw_fi_ratio_2015$profit_44 - (raw_fi_ratio_2016$profit_44 - raw_fi_ratio_2012$profit_44)/4
train_fi_ratio_2016$DEPS <- ifelse(train_fi_ratio_2016$dEPS > 0, 1, 0)
train_fi_ratio_2016$FDEPS <- as.factor(train_fi_ratio_2016$DEPS)

train_2016_sel_val <- select(train_fi_ratio_2016, -growth_5, -profit_3, -profit_7, -profit_10, -profit_13, -profit_16, -profit_17, -profit_45, 
                             -productivity_1, -productivity_4, -productivity_10, -productivity_12, -productivity_13, -safety_14,
                             -earnings, -num_common_stock, -total_asset, -total_capital, -cash_divident, -dEPS, -name, -code, -year, -DEPS)

train_2016_na <- train_2016_sel_val[complete.cases(train_2016_sel_val), ]

# 2015년
train_fi_ratio_2015 <- raw_fi_ratio_2014
train_fi_ratio_2015$dEPS <- raw_fi_ratio_2015$profit_44 - raw_fi_ratio_2014$profit_44 - (raw_fi_ratio_2015$profit_44 - raw_fi_ratio_2011$profit_44)/4
train_fi_ratio_2015$DEPS <- ifelse(train_fi_ratio_2015$dEPS > 0, 1, 0)
train_fi_ratio_2015$FDEPS <- as.factor(train_fi_ratio_2015$DEPS)

train_2015_sel_val <- select(train_fi_ratio_2015, -growth_5, -profit_3, -profit_7, -profit_10, -profit_13, -profit_16, -profit_17, -profit_45, 
                             -productivity_1, -productivity_4, -productivity_10, -productivity_12, -productivity_13, -safety_14,
                             -earnings, -num_common_stock, -total_asset, -total_capital, -cash_divident, -dEPS, -name, -code, -year, -DEPS)

train_2015_na <- train_2015_sel_val[complete.cases(train_2015_sel_val), ]

# 2014년
train_fi_ratio_2014 <- raw_fi_ratio_2013
train_fi_ratio_2014$dEPS <- raw_fi_ratio_2014$profit_44 - raw_fi_ratio_2013$profit_44 - (raw_fi_ratio_2014$profit_44 - raw_fi_ratio_2010$profit_44)/4
train_fi_ratio_2014$DEPS <- ifelse(train_fi_ratio_2014$dEPS > 0, 1, 0)
train_fi_ratio_2014$FDEPS <- as.factor(train_fi_ratio_2014$DEPS)

train_2014_sel_val <- select(train_fi_ratio_2014, -growth_5, -profit_3, -profit_7, -profit_10, -profit_13, -profit_16, -profit_17, -profit_45, 
                             -productivity_1, -productivity_4, -productivity_10, -productivity_12, -productivity_13, -safety_14,
                             -earnings, -num_common_stock, -total_asset, -total_capital, -cash_divident, -dEPS, -name, -code, -year, -DEPS)

train_2014_na <- train_2014_sel_val[complete.cases(train_2014_sel_val), ]

# 2013년
train_fi_ratio_2013 <- raw_fi_ratio_2012
train_fi_ratio_2013$dEPS <- raw_fi_ratio_2013$profit_44 - raw_fi_ratio_2012$profit_44 - (raw_fi_ratio_2013$profit_44 - raw_fi_ratio_2009$profit_44)/4
train_fi_ratio_2013$DEPS <- ifelse(train_fi_ratio_2013$dEPS > 0, 1, 0)
train_fi_ratio_2013$FDEPS <- as.factor(train_fi_ratio_2013$DEPS)

train_2013_sel_val <- select(train_fi_ratio_2013, -growth_5, -profit_3, -profit_7, -profit_10, -profit_13, -profit_16, -profit_17, -profit_45, 
                             -productivity_1, -productivity_4, -productivity_10, -productivity_12, -productivity_13, -safety_14,
                             -earnings, -num_common_stock, -total_asset, -total_capital, -cash_divident, -dEPS, -name, -code, -year, -DEPS)

train_2013_na <- train_2013_sel_val[complete.cases(train_2013_sel_val), ]

# merge train data 
tmp_2017_2016_merged_train_data <- bind_rows(train_2017_na, train_2016_na)
tmp_2017_2015_merged_train_data <- bind_rows(tmp_2017_2016_merged_train_data, train_2015_na)
tmp_2017_2014_merged_train_data <- bind_rows(tmp_2017_2015_merged_train_data, train_2014_na)
train_na <- bind_rows(tmp_2017_2014_merged_train_data, train_2013_na)

# 상하위 10개씩 상관계수 그리기
train_na_df <- as.data.frame(train_na)

t <- numeric()
df <- numeric()
p <- numeric()
cor <- numeric()
for (i in 1:152) {
  tmp_cor_test <- cor.test(train_na_df[, i], as.numeric(train_na$FDEPS))
  t[i] <- tmp_cor_test[1][[1]][[1]]
  df[i] <- tmp_cor_test[2][[1]][[1]]
  p[i] <- tmp_cor_test[3][[1]]
  cor[i] <- tmp_cor_test[4][[1]][[1]]
}
cor_test <- data.frame(t, df, p, cor)
cor_test$var <- colnames(train_na[1:152])
cor_test_sorted <- cor_test %>%
  arrange(desc(cor))
cor_test_highlow <- cor_test_sorted[c(1:10, 143:152), ]
cor_test_highlow %>% 
  ggplot(aes(reorder(var, cor), cor)) +
  geom_point() +
  coord_flip()


# 전체 변수 활용하여 분석

set.seed(1000)
n <- nrow(train_na)
idx <- 1:n
train_idx <- sample(idx, n * .80)
idx <- setdiff(idx, train_idx)
validate_idx <- sample(idx, n * .20)
length(train_idx); length(validate_idx)

train_1st <- train_na[train_idx, ]
validation_1st <- train_na[validate_idx, ]
test_1st <- test_na

# logistic regression
set.seed(1000)
earnings_glm <- glm(FDEPS ~ ., data = train_1st, family = binomial)
yhat_glm <- predict(earnings_glm, newdata = validation_1st, type = 'response')
pred_glm <- prediction(yhat_glm, as.numeric(as.character(validation_1st$FDEPS)))
perf_glm <- performance(pred_glm, measure = 'tpr', x.measure = 'fpr')
performance(pred_glm, "auc")@y.values[[1]]

yhat_glm_test <- predict(earnings_glm, newdata = test_1st, type = 'response')
pred_glm_test <- prediction(yhat_glm_test, as.numeric(as.character(test_1st$FDEPS)))
perf_glm_test <- performance(pred_glm_test, measure = 'tpr', x.measure = 'fpr')
performance(pred_glm_test, "auc")@y.values[[1]]

earnings_bayesglm <- arm::bayesglm(FDEPS ~ ., data = train_1st, family = binomial)
yhat_bayesglm <- predict(earnings_bayesglm, newdata = validation_1st, type = 'response')
pred_bayesglm <- prediction(yhat_bayesglm, as.numeric(as.character(validation_1st$FDEPS)))
performance(pred_bayesglm, "auc")@y.values[[1]]

yhat_bayesglm_test <- predict(earnings_bayesglm, newdata = test_1st, type = 'response')
pred_bayesglm_test <- prediction(yhat_bayesglm_test, as.numeric(as.character(test_1st$FDEPS)))
performance(pred_bayesglm_test, "auc")@y.values[[1]]

# tree model - cart
library(rpart)
set.seed(1000)
earnings_cart <- rpart(FDEPS ~ ., data = train_1st, method = "class")
yhat_cart <- predict(earnings_cart, validation_1st)
pred_cart <- prediction(yhat_cart[, "1"], as.numeric(as.character(validation_1st$FDEPS)))
performance(pred_cart, "auc")@y.values[[1]]

yhat_cart_test <- predict(earnings_cart, newdata = test_1st)
pred_cart_test <- prediction(yhat_cart_test[, "1"], as.numeric(as.character(test_1st$FDEPS)))
performance(pred_cart_test, "auc")@y.values[[1]]

yhat_cart_prob <- predict(earnings_cart, validation_1st, type = "prob")[, 2]
pred_cart_prob <- prediction(yhat_cart_prob, as.numeric(as.character(validation_1st$FDEPS)))
perf_cart <- performance(pred_cart_prob, measure = 'tpr', x.measure = 'fpr')
performance(pred_cart_prob, "auc")@y.values[[1]]

yhat_cart_prob_test <- predict(earnings_cart, newdata = test_1st, type = "prob")[,2]
pred_cart_prob_test <- prediction(yhat_cart_prob_test, as.numeric(as.character(test_1st$FDEPS)))
perf_cart_test <- performance(pred_cart_prob_test, measure = 'tpr', x.measure = 'fpr')
performance(pred_cart_prob_test, "auc")@y.values[[1]]

# randomForest
library(randomForest)
set.seed(1000)
earnings_rf <- randomForest(FDEPS ~ ., mtry = floor(sqrt(153)), ntree = 500, data = train_1st)
yhat_rf <- predict(earnings_rf, newdata = validation_1st, type = 'prob')[, '1']
pred_rf <- prediction(yhat_rf, as.numeric(as.character(validation_1st$FDEPS)))
perf_rf <- performance(pred_rf, measure = 'tpr', x.measure = 'fpr')
performance(pred_rf, "auc")@y.values[[1]]

yhat_rf_test <- predict(earnings_rf, newdata = test_1st, type = 'prob')[, '1']
pred_rf_test <- prediction(yhat_rf_test, as.numeric(as.character(test_1st$FDEPS)))
perf_rf_test <- performance(pred_rf_test, measure = 'tpr', x.measure = 'fpr')
performance(pred_rf_test, "auc")@y.values[[1]]

# boosting - gbm
library(gbm)
set.seed(1000)
earnings_gbm <- gbm(as.numeric(as.character(FDEPS)) ~ . , data = train_1st, distribution = "bernoulli", n.trees = 50000, cv.folds = 3, verbose = T)
best_tier <- gbm.perf(earnings_gbm, method = "cv")
yhat_gbm <- predict(earnings_gbm, n.trees = best_tier, newdata = validation_1st, type = 'response')
pred_gbm <- prediction(yhat_gbm, as.numeric(as.character(validation_1st$FDEPS)))
perf_gbm <- performance(pred_gbm, measure = 'tpr', x.measure = 'fpr')
performance(pred_gbm, "auc")@y.values[[1]]

yhat_gbm_test <- predict(earnings_gbm, n.trees = best_tier, newdata = test_1st, type = 'response')
pred_gbm_test <- prediction(yhat_gbm_test, as.numeric(as.character(test_1st$FDEPS)))
perf_gbm_test <- performance(pred_gbm_test, measure = 'tpr', x.measure = 'fpr')
performance(pred_gbm_test, "auc")@y.values[[1]]

# ROC 곡선 그리기
par(mfrow = c(2, 2))

plot(perf_glm, main = 'ROC Curve for Logistic Model', lty = 1)
plot(perf_glm_test, add = TRUE, lty = 2)
abline(0, 1)
legend('bottomright', inset = 0.1, legend = c("Validation ROC", "Test ROC"), lty = c(1, 2), lwd = 2)

plot(perf_cart, main = 'ROC Curve for Tree Model', lty = 1)
plot(perf_cart_test, add = TRUE, lty = 2)
abline(0, 1)
legend('bottomright', inset = 0.1, legend = c("Validation ROC", "Test ROC"), lty = c(1, 2), lwd = 2)

plot(perf_rf, main = 'ROC Curve for Random Forest Model', lty = 1)
plot(perf_rf_test, add = TRUE, lty = 2)
abline(0, 1)
legend('bottomright', inset = 0.1, legend = c("Validation ROC", "Test ROC"), lty = c(1, 2), lwd = 2)

plot(perf_gbm, main = 'ROC Curve for Boosting Model', lty = 1)
plot(perf_gbm_test, add = TRUE, lty = 2)
abline(0, 1)
legend('bottomright', inset = 0.1, legend = c("Validation ROC", "Test ROC"), lty = c(1, 2), lwd = 2)

par(mfrow = c(1,1))

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

roc_glm_validation <- pROC::roc(response = validation_1st$FDEPS, predictor = yhat_glm)
roc_cart_validation <- pROC::roc(response = validation_1st$FDEPS, predictor = yhat_cart_prob)
roc_rf_validation <- pROC::roc(response = validation_1st$FDEPS, predictor = yhat_rf)
roc_gbm_validation <- pROC::roc(response = validation_1st$FDEPS, predictor = yhat_gbm)

set.seed(1000)
roc_validation_glm_cart <- pROC::roc.test(roc_glm_validation, roc_cart_validation, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_validation_glm_cart

set.seed(1000)
roc_validation_glm_rf <- pROC::roc.test(roc_glm_validation, roc_rf_validation, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_validation_glm_rf

set.seed(1000)
roc_validation_glm_gbm <- pROC::roc.test(roc_glm_validation, roc_gbm_validation, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_validation_glm_gbm

set.seed(1000)
roc_validation_cart_rf <- pROC::roc.test(roc_cart_validation, roc_rf_validation, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_validation_cart_rf

set.seed(1000)
roc_validation_cart_gbm <- pROC::roc.test(roc_cart_validation, roc_gbm_validation, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_validation_cart_gbm

set.seed(1000)
roc_validation_rf_gbm <- pROC::roc.test(roc_rf_validation, roc_gbm_validation, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_validation_rf_gbm

roc_glm_test <- pROC::roc(response = test_1st$FDEPS, predictor = yhat_glm_test)
roc_cart_test <- pROC::roc(response = test_1st$FDEPS, predictor = yhat_cart_prob_test)
roc_rf_test <- pROC::roc(response = test_1st$FDEPS, predictor = yhat_rf_test)
roc_gbm_test <- pROC::roc(response = test_1st$FDEPS, predictor = yhat_gbm_test)

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
roc_test_cart_rf <- pROC::roc.test(roc_cart_test, roc_rf_test, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_test_cart_rf

set.seed(1000)
roc_test_cart_gbm <- pROC::roc.test(roc_cart_test, roc_gbm_test, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_test_cart_gbm

set.seed(1000)
roc_test_rf_gbm <- pROC::roc.test(roc_rf_test, roc_gbm_test, method = "bootstrap", boot.n = 500, progress = "none", paired = T)
roc_test_rf_gbm

library(caret)
# varImp의 레퍼런스 https://www.rdocumentation.org/packages/caret/versions/6.0-84/topics/varImp

# gbm의 method 인자 설명 
# The function used to compute the relative influence. relative.influence is
# the default and is the same as that described in Friedman (2001). The other current (and experimental) choice is permutation.test.gbm. This method randomly permutes each predictor variable at a time and computes the associated
# reduction in predictive performance. This is similar to the variable importance
# measures Breiman uses for random forests, but gbm currently computes using
# the entire training dataset (not the out-of-bag observations).

summary(earnings_glm)
varImp(earnings_glm)

summary(earnings_cart)
varImp(earnings_cart)

summary(earnings_rf)
varImp(earnings_rf)

summary(earnings_gbm)


