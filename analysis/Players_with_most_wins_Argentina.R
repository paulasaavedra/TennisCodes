library(dplyr)
library(tidyr)
library(kableExtra)


dbm <- db [tourney_level != 'CH']
dbm <- dbm [match_status != 'Walkover']
#dbm <- dbm [surface =='Clay']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

dbm <- dbm [year=='2025']
jugadores_que_mas_derrotaron_argentinos <- dbm [l_nac == 'Argentina',.N,by=c('w_player')]


