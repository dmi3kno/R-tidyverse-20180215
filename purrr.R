library(tidyverse)
library(stringr)

gapminder <- gapminder::gapminder
gapminder

gapminder %>% 
  filter(str_detect(country, "Rep")) %>% 
  select(country) %>% 
  distinct()


dr_string <- "Congo, Dem. Rep."
dr_string

dr_pattern <- ", Dem\\. Rep\\."

str_detect(dr_string, dr_pattern)
str_replace(dr_string, dr_pattern, "")
str_c("Democratic Republic of ",
  str_replace(dr_string, dr_pattern, ""))

start <- str_locate(dr_string, dr_pattern)[1,1]

start

str_sub(dr_string, start = start)
str_sub(dr_string, end = start-1)

gapm_text <- read_lines("https://www.gapminder.org/wp-content/themes/gapminder/cronJobs/json.js")
gapm_text

g_pattern <- "var indicatorsJson="

str_replace(gapm_text, g_pattern, "")
str_locate(gapm_text, g_pattern)
gapm_text <- str_sub(gapm_text, start=20)

gapm_json <- str_c("[", gapm_text, "]")

gapm_list <- jsonlite::fromJSON(gapm_json, 
                  simplifyVector = FALSE)

gapm_list %>% View
# subsetting lists

# does not peel off the packaging
gapm_list[1] %>% View

# extracts the content of a list. 
# peeling off the packaging
gapm_list[[1]] %>% View

gapm_list <- gapm_list[[1]]

length(gapm_list)

gapm_list[[1]] %>% View

# reaching out to 5th element of 1 element of the list
gapm_list[[1]][[5]]
gapm_list[[1]][["dataprovider_link"]]
gapm_list[[1]]$dataprovider_link

map(gapm_list, 5) %>% View
map(gapm_list, "indicatorName") %>% View

map(gapm_list, "indicatorName") %>% 
  simplify() 
#
# map(<LIST>, <FUNCTION>, <ARGUMENTS_IF_ANY>)

a <- 1:5
b <- 4:9


tibble(sheet_id=names(gapm_list),
       indicatorName=map(gapm_list, "indicatorName") %>% simplify(),
       category=map_chr(gapm_list, "category"),
       subcategory=map_chr(gapm_list, "subcategory"),
       dataprovider=map_chr(gapm_list, "dataprovider"),
       dataprovider_link=map_chr(gapm_list, "dataprovider_link")
       ) %>% 
  write_csv("gapminder_datasources.csv")













