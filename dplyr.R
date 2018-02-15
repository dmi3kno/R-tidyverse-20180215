#' Lunsj dag 1
#' Tema etter lunsj er datamanipulering 
#' 
library("tidyverse")

gapminder <- gapminder::gapminder

gapminder

#' Alt er basert på piping med syntaxen %>%. Følgende er forskjellige manipuleringer
#' med diverse syntakser, Select
#' 
gapminder %>% select(-gdpPercap)


year_country_gdp <- gapminder %>% 
  select(year,country, gdpPercap)

#' Kombo med piping inn i ggplot, som står for selve visualiseringen, 
#' her med geom_boxplot
#' 
gapminder %>% 
  filter(year==2002) %>% 
  ggplot(mapping=aes(x=continent, y=pop))+
  geom_boxplot()

#' Kombo med piping, merk at filtrering på kontinent, som må gjøres FØRST pga selectene
#' 
gapminder %>% 
  filter(continent=="Europe") %>% 
  select(year,country,gdpPercap)
  ggplot(mapping=aes(x=continent, y=pop))+
  geom_boxplot()

#'Oppgave 1
  
gapminder %>% 
  filter(country=="Norway") %>% 
  select(gdpPercap, lifeExp,year)
  
#'Group by sammen med en utregning. Etabler variabel og regn ut i samme slengen

gapminder %>% 
  group_by(continent) %>% 
  summarise(mean_gdpPercap = mean(gdpPercap))

#'Oppgave 2 (With a twist)

gapminder %>% 
  group_by(country) %>%
  filter(continent=="Asia") %>% 
  summarise(mean_lifeExpect = mean(lifeExp)) %>% 
  ggplot(mapping=aes(y=country, x=mean_lifeExpect))+
  geom_point()

gapminder %>% 
  group_by(country) %>%
  filter(continent=="Asia") %>% 
  summarise(mean_lifeExpect = mean(lifeExp)) %>% 
  filter(mean_lifeExpect== min(mean_lifeExpect)|mean_lifeExpect==max(mean_lifeExpect))

#'andre kalkulasjoner, utrekket begrenser handlingsrommet nedover
 
gapminder %>% 
  group_by(continent, year) %>% 
  summarise(mean_gdpPercap=mean(gdpPercap),
            sd_gdpPercap=sd(gdpPercap),
            mean_pop=mean(pop),
            sd_pop=sd(pop))

#' Mutasjoner (dublering/kreering av nye kolonner)
gapminder %>% 
  mutate(gdp_billion=gdpPercap*pop/10^9)
  
#'Oppgave 3   
  
gapminder %>% 
  mutate(gdp_billion=gdpPercap*pop/10^9) %>% 
  group_by(continent) %>%
  filter(year=="1987") %>% 
  summarise(mean_lifeExpect = mean(lifeExp), mean_gdp_billion=mean(gdp_billion)) %>% 
  select(continent, mean_lifeExpect, mean_gdp_billion)

#' kreere nytt objekt
#' 

gapminder_country_summary <- gapminder %>% 
  group_by(country) %>% 
  summarise(mean_lifeExpect = mean(lifeExp))

#'Bruke det nye objektet til å vise på kart

map_data("world") %>% 
  rename(country=region) %>% 
  left_join(gapminder_country_summary, by="country") %>% 
  ggplot()+
  geom_polygon(mapping = aes(x=long, y=lat, group=group, 
                             fill=mean_lifeExpect))
  
  