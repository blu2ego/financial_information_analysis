library(rvest)
library(readr)
library(dplyr)

tem <- read_lines("~/projects/financial_information_analysis/data/business_report/new_dart/sample/20200330003851.xml")
Encoding(tem) <- "CP949"
tem <- iconv(tem, from = "Cp949", to = "UTF-8")
write_lines(tem, "tes.xml")
tem <- read_html("tes.xml")

a <- tem %>% 
       html_nodes("table") %>%
       html_table(fill = T)

a <- tem %>% 
  html_nodes("te")
  

#############################################################################################

case_1 <- read_html("~/projects/financial_information_analysis/data/business_report/new_dart/sample/20200330003851_cr.xml", 
                    encoding = "euc-kr")

a <- html_nodes(case_1, 'table') %>%
  html_table(fill = T)

grep("감사용역", a)

grep("&cr;", tc)
