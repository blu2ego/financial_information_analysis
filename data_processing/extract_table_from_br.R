library(tabulizer)

tables <- extract_tables("~/projects/financial_information_analysis/data/dart/br/br.pdf")
str(tables)
tables[1]
