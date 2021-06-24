## differential_market_reaction_to_sustainability_report_by_language

list_sr_eng <- list.files("~/data2/ward_data/ksr/eng/", full.names = T)
list_sr_kor <- list.files("~/data2/ward_data/ksr/kor/")

library(tabulizer)
library(pdftools)

sr_text <- pdftools::pdf_text(list_sr_eng[1])

library(tidytext)
library(RcppMeCab)
