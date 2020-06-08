library(pdftools)
br_text <- pdf_text("~/projects/financial_information_analysis/data/business_report/dart/sample/br.pdf")

search_word <- c("감사용역", "감사 용역")
bag_search_word <- paste(search_word, collapse = "|")
where_audit_table <- grep(bag_search_word, br_text)

library(tabulizer)
br_tables <- extract_tables("~/projects/financial_information_analysis/data/business_report/dart/sample/br.pdf", 
                            pages = where_audit_table, output = "data.frame")


audit_raw <- as.data.frame(br_tables[1])
audit <- audit_raw[, -3]
audit <- audit[!(audit$사업연도 == "" ), ]
audit
