####################################
#       Libraries                 #
####################################

library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(dplyr)
library(sqldf)
library(DT)
library(rtweet)
library(stringr)
library(leaflet)
library(shinycssloaders)
library(plotly)
library(shinyalert)
library(lubridate)
library(tidyverse)
library(twitteR)
library(leaflet.extras)


##################NBA#####################
# nba <- search_tweets(q="NBA", n = 18000, include_rts = FALSE, lang= "es-es")

# write.csv(nfl, "nfl.csv", row.names = FALSE)

nba = read.csv("nba.csv", header = TRUE)

# nba = nba_messds
#
# nfl <- nfl_messds %>%
#     select(created_at, screen_name, text, favorite_count,
#            retweet_count, status_url, name, location, followers_count, lat, lng)

nba$Sport<- "NBA"

colnames(nba) <- c("Date","UserID","Tweet",
                   "Favorites","Retweets",
                   "url","Name","Location",
                   "Followers","lat","lng","source","Sport")

nba$Interactions <- nba$Favorites + nba$Retweets

nba <- nba %>%
    mutate(Tweet = str_to_lower(Tweet))

nba$Date <- format(as.Date(nba$Date, format= "%Y-%m-%d"))

nba_cleands <- nba #Dataset limpiado para guardar


################NFL####################

# nfl <- search_tweets(q="NFL", n = 18000, include_rts = FALSE, lang= "es-es", since = '2021-02-03', until = '2021-02-10')

nfl = read.csv("nfl.csv", header = TRUE)

# nfl_messds <- nfl ##Dataset sin limpiar
# 
# nfl <- nfl %>%
#     select(created_at, screen_name, text, favorite_count,
#             retweet_count, status_url, name, location, followers_count)

nfl$sport <- "NFL"

colnames(nfl) <- c("Date","UserID","Tweet",
                   "Favorites","Retweets",
                   "url","Name","Location",
                   "Followers","lat","lng","source", "Sport")

nfl$Interactions <- nfl$Favorites + nfl$Retweets

nfl <- nfl %>%
         mutate(Tweet = str_to_lower(Tweet))

nfl$Date <- format(as.Date(nfl$Date, format= "%Y-%m-%d"))

nfl_cleands <- nfl

totds <- merge(nba, nfl,all=T) ##PARA JUNTAR LOS DATASETS


