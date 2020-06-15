# xml to data frame
lapply(seq_along(food_node),
       function(x){
         temp_row <- xml_find_all(food_node[x], './*')
         tibble(
         idx = x,
         key = temp_row %>% xml_name(),
         value = temp_row %>% xml_text()
         ) %>% return()
       }
       ) %>% bind_rows() %>%
spread(key, value) %>%
select(food_node %>% xml_children() %>% xml_name %>% unique())
