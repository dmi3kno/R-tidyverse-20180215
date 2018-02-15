library("readxl")

raw_fert <- read_excel("indicator undata total_fertility.xlsx")

raw_fert

fert <- raw_fert %>% 
  rename(country = `Total fertility rate`) %>% 
  gather(key = year, value = fert, -country) %>% 
  mutate(year = as.integer(year))

fert

raw_infantMort <- read_excel("indicator gapminder infant_mortality.xlsx")

infantMort <- raw_infantMort %>% 
  rename(country = `Infant mortality rate`) %>% 
  gather(key = year, value = infantMort, -country) %>% 
  mutate(year = as.integer(year),
         infantMort = as.numeric(infantMort))

gapminder_plus <- gapminder %>% 
  left_join(fert, by = c("year", "country")) %>% 
  left_join(infantMort, by = c("year", "country"))

gapminder_plus

write_csv(gapminder_plus, "gapminder_plus.csv")

