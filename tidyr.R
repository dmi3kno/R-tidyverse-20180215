
#Prosjekt med nye data fra Gapminder, med funksjoner for å lese inn excel-regneark, samt flate ut data.
#Istedet for vide data, så flyttes de over til få kollonner med mange rader.

library("readxl")

raw_fert <- read_excel("indicator undata total_fertility.xlsx")

raw_fert

# Her foretas selve flyttingen og utflatingen av regnearket til en enklere
# tabell som er bedre tilpasset bruk i tidyr
fert <- raw_fert %>% 
  rename(country=`Total fertility rate`) %>% 
  gather(key=year, value=fert, -country) %>% 
  mutate(year=as.integer(year))

fert

raw_mort <- read_excel("indicator gapminder infant_mortality.xlsx")

raw_mort

mort <-raw_mort %>% 
  rename(country=`Infant mortality rate`)%>% 
  gather(key=year, value=Inmort, -country) %>% 
  mutate(year=as.integer(year))

mort

# lage left join

gapminder_plus<- gapminder %>% 
  left_join(fert,by=c("year","country")) %>% 
  left_join(mort,by=c("year","country"))

