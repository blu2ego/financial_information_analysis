download.file("https://higherlogicdownload.s3.amazonaws.com/NASBO/9d2d2db1-c943-4f1b-b750-0fca152d64c2/UploadedImages/SER%20Archive/2010%20State%20Expenditure%20Report.pdf", "nasbo09_11.pdf", mode = "wb")

txt14_16 <- pdf_text("~/projects/financial_information_analysis/data/sample/nasbo09_11.pdf")

library(tidyverse)

df <- txt14_16[56] %>% 
  read_lines() %>%    # separate lines
  grep('^\\s{2}\\w', ., value = TRUE) %>%    # select lines with states, which start with space, space, letter
  paste(collapse = '\n') %>%    # recombine
  read_fwf(fwf_empty(.)) %>%    # read as fixed-width file
  mutate_at(-1, parse_number) %>%    # make numbers numbers
  mutate(X1 = sub('*', '', X1, fixed = TRUE))    # get rid of asterisks in state names