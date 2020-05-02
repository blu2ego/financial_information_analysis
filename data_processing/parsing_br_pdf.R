library(pdftools)  # pdf에서 텍스트 파싱
report.1 <- pdf_text("~/R/nabataea/br_sample/795278.pdf")
report.2 <- pdf_text("~/R/nabataea/br_sample/7046364.pdf")

library(stringr)
report.1.split <- str_split(report.1, "\r\n")
report.1.split[1]

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
str_extract(idx.3.step.1, c("([가-힣]+)", "([가-힣]+)", "([0-9]+)"))


library(tidyr)
char.idx.2.step.2 <- as.character(unlist(idx.2.step.2))
char.idx.2.step.2
class(char.idx.2.step.2)
tidyr::extract(char.idx.2.step.2, into = c("Title", "Page"), regex = "([가-힣])([가-힣])([가-힣])([가-힣])([가-힣])([0-9])")



class(char.idx.2.step.2)

report.2.split <- str_split(report.2, "\r\n")
report.2.split[1]



library(tabulizer) # pdf에서 표 추출
report.tables <- extract_tables("C:/Users/muoe7/Documents/R/nabataea/br_sample/7046364.pdf")
report.tables[1]
