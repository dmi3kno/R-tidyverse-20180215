#' ---
#' title: "R tidyverse workshop"
#' author: "`Carpentry@UiO`"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---

#' *Read more about this type of document in 
#' [Chapter 20 of "Happy Git with R"](http://happygitwithr.com/r-test-drive.html)*
#'  
#' Uncomment the following lines to install necessary packages

#install.packages("tidyverse")
#install.packages("maps")
#install.packages("gapminder")

#' First we need to load libraries installed previously
library(tidyverse)

#' We will source `gapminder` dataset into the session and assign it 
#' to the variable with the same name
gapminder <- gapminder::gapminder

gapminder

#' Generally speaking ggplot2 syntax follows the template:
# ggplot(<DATA>) +
#   geom_<GEOM_FUNCTION>(mapping=aes(<AESTETICS>))

#' Let's learn some more about `ggplot2` and its functions!


#' Let's make our first plot
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp))

#' Bytte akser
ggplot(gapminder)+
  geom_point(mapping = aes(x=lifeExp, y=gdpPercap))

#' Bruke år og bytte akser
ggplot(gapminder)+
  geom_jitter(mapping = aes(y=gdpPercap, x=year))

#' Bruke jitter og fargelegge på kontinent (den 3 dimensjon)
ggplot(gapminder)+
  geom_jitter(mapping = aes(x=gdpPercap, y=lifeExp, color=continent))

#' Bruke jitter og fargelegge på kontinent (den 3 dimensjon)
ggplot(gapminder)+
  geom_jitter(mapping = aes(x=gdpPercap, y=pop, color=continent))

#' Bruke jitter og fargelegge på år (den 3 dimensjon)
ggplot(gapminder)+
  geom_jitter(mapping = aes(y=lifeExp, x=continent, color=year))

#' first plot med farver på år, samt logaritmen av gdpPercap
ggplot(gapminder)+
  geom_point(mapping = aes(x=log(gdpPercap), y=lifeExp, color=year))

#' first plot med farver på continent, bubbles på population samt logaritmen av gdpPercap
ggplot(gapminder)+
  geom_point(mapping = aes(x=log(gdpPercap), y=lifeExp, 
                           color=continent, size=pop))

#' first plot med farver på år, boblestørrelse på population, shape på kontinent 
#' samt logaritmen av gdpPercap
ggplot(gapminder)+
  geom_point(mapping = aes(x=log(gdpPercap), y=lifeExp, 
                           color=year, size=pop, shape=continent))

#' first plot, redusere overplotting med farver og gjennomsiktighet per punkt.
#' farver og alpha er holdt utenfor parantesen (merk!)
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp),color="blue", alpha=0.1)



#' Geometric functions med linjer (ny visualiseringsmåte)
#' 
ggplot(gapminder) +
  geom_line(mapping=aes(x=year, y=lifeExp, group=country, color=continent))

#' Boxplot functions (ny visualiseringsmåte)
#' 
ggplot(gapminder) +
  geom_boxplot(mapping=aes(x=continent, y=lifeExp, color=continent))

#' Point functions (ny visualiseringsmåte)
#' 
ggplot(gapminder) +
  geom_point(mapping=aes(x=continent, y=lifeExp, color=continent))

#' Blande to layers med  jitter og box functions (ny visualiseringsmåte)
#' Legg på så mange lag som du gidder
ggplot(gapminder) +
  geom_jitter(mapping=aes(x=continent, y=lifeExp, color=continent)) +
  geom_boxplot(mapping=aes(x=continent, y=lifeExp, color=continent))
 
#' Blande to layers forenkelt kode, utrykket sendes som et paramter ned til funksjonene
ggplot(gapminder,mapping=aes(x=continent, y=lifeExp, color=continent)) +
  geom_jitter() +
  geom_boxplot()

#' To lag 1: basis i "first plot med farver på år, samt logaritmen av gdpPercap"
ggplot(gapminder, mapping = aes(x=log(gdpPercap), y=lifeExp))+
  geom_point()+
  geom_smooth(method="lm")

#' Modifisert 2: To lag: basis i "first plot med farver på år, 
#' samt logaritmen av gdpPercap" med regression. Farver kontrolleres på "barn", ikke på "mor"
ggplot(gapminder, mapping = aes(x=log(gdpPercap), y=lifeExp))+
  geom_point(mapping=aes(color=continent), alpha=0.5) + geom_smooth(method="lm")

 
#' Modifisert 3: To lag: basis i "first plot med farver på år, 
#' ,med regression. logaritmen utenfor utrykket. Farver kontrolleres på "barn", ikke på "mor"
ggplot(gapminder, mapping = aes(x=gdpPercap, y=lifeExp))+
  geom_point(mapping=aes(color=continent), alpha=0.5) + 
  geom_smooth(method="loess")+scale_x_log10()

#' Oppgave 6: Boxplot med lifeexpactancy per year. Husk GROUP
ggplot(gapminder,mapping=aes(x=year, group=year, y=lifeExp)) +
  geom_boxplot()

#' Oppgave 6a: Boxplot med gdpPerCap per year (ulikheter per år). Husk GROUP
ggplot(gapminder,mapping=aes(x=year, group=year, y=gdpPercap)) +
  geom_boxplot() + scale_y_log10()

#' Oppgave 6: Histogram  med gdpPerCap per year (ulikheter per år). 
ggplot(gapminder) +
  geom_histogram(mapping=aes(x=gdpPercap), binwidth = 100)

#' Oppgave 6b: density  med gdpPerCap /lifeexpt. 
ggplot(gapminder) +
  geom_density(mapping=aes(x=gdpPercap, color=continent))+
  scale_x_log10()


#' Oppgave 6c: Density 2d  med gdpPerCap/lifeexpt. 
ggplot(gapminder) +
  geom_density2d(mapping=aes(x=gdpPercap, y=lifeExp))+
  scale_x_log10()

#' Oppgave 6d: Point  med gdpPerCap/lifeexpt. Wrap og grid påkontinent
ggplot(gapminder) +
  geom_point(mapping=aes(x=gdpPercap, y=lifeExp))+
  facet_wrap(~continent)

#' Oppgave 6e: Point  med gdpPerCap/lifeexpt. Wrap og grid på år
ggplot(gapminder) +
  geom_point(mapping=aes(x=gdpPercap, y=lifeExp))+
#  scale_x_log10()+
  facet_wrap(~year)

#' Oppgave 6f: Point  med gdpPerCap/lifeexpt.
ggplot(gapminder) +
  geom_point(mapping=aes(x=gdpPercap, y=lifeExp, color=continent, size=pop))+
  scale_x_log10() +
  labs(x="GDP per capita i USD", y="Life expectancy at birth in years", 
       color="Continent",size="Population")
  # facet_wrap(~year)
