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

#' Let's make our first plot
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp))

#' Generally speaking ggplot2 syntax follows the template:
# ggplot(<DATA>) +
#   geom_<GEOM_FUNCTION>(mapping=aes(<AESTETICS>))

#' Let's learn some more about `ggplot2` and its functions!

## Imagine the rest of the script from before lunch!  

kdsgfkgsadf