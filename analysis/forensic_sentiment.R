list_reports <- c()
list_reports <- list.files(path = "~/projects/iaa/data/forensic/reports/", full.names = T)
length(list_reports)

library(stringi)
df_list_reports <- data.frame(path = list_reports,
                          unique_code = unlist(stri_extract_all(str = list_reports, regex = "(?<=O001_)[0-9]{8}")),
                          doc_no = unlist(stri_extract_all(str = list_reports, regex = "[0-9]{14}")))
df_list_reports[, "year"] <- as.numeric(substr(x = df_list_reports$doc_no, start = 1, stop = 4))
df_list_reports$year <- df_list_reports$year -1

library(pdftools)
rows <- data.frame()
for (i in 1:length(full$unique)) {
  print(i)
  code <- full$unique[i]
  print(code)
  yyyy <- full$fiscal_year[i]
  print(yyyy)
  selected_row <- subset(df_list_reports, unique_code == code & year == yyyy)
  print(selected_row)
  rows <- rbind(rows, selected_row)
  tmp_txt <- pdftools::pdf_text(rows[i, 1])
  tmp_txt <- pdf_text(selected_row$path)
  full_4$report_txt[i] <- paste(tmp_txt, collapse = "") 
}

library(stringr)
full$report_txt <- str_replace_all(full$report_txt, "\\.", "")
full$report_txt <- str_replace_all(full$report_txt, "-", "")
full$report_txt <- stripWhitespace(full$report_txt)
full$report_txt <- str_replace_all(full$report_txt, "dartfssorkr Page 7", "")
full$report_txt <- str_replace_all(full$report_txt, "dartfssorkr Page 6", "")
full$report_txt <- str_replace_all(full$report_txt, "dartfssorkr Page 5", "")
full$report_txt <- str_replace_all(full$report_txt, "dartfssorkr Page 4", "")
full$report_txt <- str_replace_all(full$report_txt, "dartfssorkr Page 3", "")
full$report_txt <- str_replace_all(full$report_txt, "dartfssorkr Page 2", "")
full$report_txt <- str_replace_all(full$report_txt, "dartfssorkr Page 1", "")
full$report_txt <- str_replace_all(full$report_txt, "[[:lower:]]", "")
full$report_txt <- str_replace_all(full$report_txt, "\\(", "")
full$report_txt <- str_replace_all(full$report_txt, "\\)", "")
full$report_txt <- str_replace_all(full$report_txt, "'", "")
full$report_txt <- str_replace_all(full$report_txt, '"', "")
full$report_txt <- str_replace_all(full$report_txt, ':', "")
full$report_txt <- str_replace_all(full$report_txt, "\\\\", "")
full$report_txt <- str_replace_all(full$report_txt, '전자공시시스템', "")
full$report_txt <- str_replace_all(full$report_txt, "[[:digit:]]", "")
full$report_txt <- str_replace_all(full$report_txt, "─", "")
full$report_txt <- str_replace_all(full$report_txt, "①", "")
full$report_txt <- str_replace_all(full$report_txt, "②", "")
full$report_txt <- str_replace_all(full$report_txt, "③", "")
full$report_txt <- str_replace_all(full$report_txt, "\\\\", "")
full$report_txt <- stripWhitespace(full$report_txt)

library(googleLanguageR)
gl_auth("~/projects/keys/woojune-int-20200514-77a6e29d73b9.json")
magnitude <- c()
score <- c()
for (i in 1:length(full$unique)) {
  senti <- gl_nlp(full$report_txt[i])
  magnitude[i] <- senti[[6]][[1]]
  score[i] <- senti[[6]][[2]]
}
sa <- data.frame(magnitude, score)
full$senti_magnitude <- magnitude
full$senti_score <- score

