library(pdftools)  # pdf에서 텍스트 파싱
report.1 <- pdf_text("~/projects/financial_information_analysis/data/business_report/dart/sample/br.pdf")

library(stringr)
report.1.split <- str_split(report.1, "\n")

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

