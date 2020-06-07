library(pdftools)  # pdf에서 텍스트 파싱
report.1 <- pdf_text("~/projects/financial_information_analysis/data/business_report/dart/sample/br.pdf")
report.2 <- pdf_text("~/projects/financial_information_analysis/data/business_report/dart/sample/7046364.pdf")
report.3 <- pdf_text("~/projects/financial_information_analysis/data/business_report/dart/sample/795278.pdf")
report.1[1]

library(stringr)
report.1.split <- str_split(report.1, "\n")
report.2.split <- str_split(report.1, "\n")
report.3.split <- str_split(report.1, "\n")


idx.1 <- report.1.split[[1]][1]
str_replace_all(idx.1, pattern = " ", replacement = "")

idx.2 <- report.1.split[[1]][2]
idx.2.step.1 <- str_replace_all(idx.2, pattern = "\\.", replacement = "")
idx.2.step.2 <- str_replace_all(idx.2.step.1, pattern = " ", replacement = "")
idx.2.step.2
str_extract(idx.2.step.2, c("([가-힣]+)", "([0-9]+)"))

idx.3 <- report.1.split[[1]][3]
idx.3
idx.3.step.1 <- str_replace_all(idx.3, pattern = "\\.", replacement = "")
idx.3.step.1
idx.3.step.2 <- str_replace_all(idx.3.step.1, pattern = " ", replacement = "")
idx.3.step.2
str_extract(idx.3.step.2, c("([가-힣]+)", "([0-9]+)"))

idx_seaech_word_1 <- "감사용역"
idx_seaech_word_2 <- "감사 용역"

which(report.1 = "감사용역")
