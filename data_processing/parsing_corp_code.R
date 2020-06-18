library(xml2)
library(tidyverse)

corpcode_yymmdd <- format(Sys.Date(), "%Y%m%d")

corpcode <- read_xml("~/projects/financial_information_analysis/data/corp_general_info/CORPCODE.xml")

# xml to data frame
assign(paste0("corpcode", corpcode_yymmdd), 
       lapply(seq_along(result_node),
              function(x){
                temp_row <- xml_find_all(result_node[x], './*')
                tibble(
                  idx = x,
                  key = temp_row %>% xml_name(),
                  value = temp_row %>% xml_text()
                       ) %>% 
                  return()
                }
              ) %>% 
         bind_rows() %>%
         spread(key, value) %>%
         select(result_node %>% 
                  xml_children() %>% 
                  xml_name %>% 
                  unique()
                )
       )
