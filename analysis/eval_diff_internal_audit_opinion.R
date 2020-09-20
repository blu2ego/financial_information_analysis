#################################################################################################
## evaluation of difference between audit opinion for internal accounting management for firms ##
#################################################################################################

#######################################
## load data from package accounting ##
#######################################

# install_github("blu2ego/accounting")
library(accounting)
data("internal")

###############################################
## 01. process data to extract the audit opinion ##
###############################################

###########################################################################
## 01.01 internal에서 내부회계관리제도 감사보고서 텍스트만 분리 추출하기 ##
###########################################################################
firms_obs <- length(internal)
iao <- vector(mode = "list", firms_obs) # 사전에 리스트의 길이를 정의. 이렇게 사전에 정의하지 않으면, for 구문에서 subscript out of bounds 에러가 남.
for (i in 1:firms_obs) {
  year_obs <- length(internal[[i]])
  for (j in 1:year_obs) {
    iao[[i]][[j]] <- internal[[i]][[j]][["내부회계관리제도 감사보고서"]]  
  }
}

#############################################################
## 01.01에서 추출한 텍스트에서 필요 없는 특수 문자 등 제거 ##
#############################################################


iao_cleaned <- gsub("=", replacement = "", iao[[1]][[1]])
iao_cleaned <- gsub("@", replacement = "", iao_cleaned)
iao_cleaned <- gsub('\"', replacement = "", iao_cleaned)
iao_cleaned <- gsub("'", replacement = "", iao_cleaned)
iao_cleaned <- gsub('\"', replacement = "", iao_cleaned)
library(stringr)
iao_cleaned <- str_squish(iao_cleaned)
iao_cleaned <- gsub("삼 덕 회 계 법 인", replacement = "삼덕회계법인", iao_cleaned)
iao_cleaned <- gsub("첨부 : 1. 독립된감사인의 내부회계관리제도 검토보고서 2. 회사의 내부회계관리제도 운영실태 평가보고서", replacement = "", iao_cleaned)
iao_cleaned <- gsub("운영실태보고내용", replacement = "운영실태보고 내용", iao_cleaned)
iao_cleaned <- str_squish(iao_cleaned)
iao_cleaned <- gsub("우리의책임", replacement = "우리의 책임", iao_cleaned)
iao_cleaned <- gsub("보고하는데", replacement = "보고하는 데", iao_cleaned)
iao_cleaned <- gsub("운영실태보고내용", replacement = "운영실태보고 내용", iao_cleaned)
iao_cleaned <- gsub("상장중소기업 으로서", replacement = "상장중소기업으로서", iao_cleaned)
iao_cleaned <- gsub("경영자의운영실태보고", replacement = "경영자의 운영실태보고", iao_cleaned)
iao_cleaned
grep("취약점", iao_cleaned)
