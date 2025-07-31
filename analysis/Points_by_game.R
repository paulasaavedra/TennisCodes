library(dplyr)
library(tidyr)
library(kableExtra)


dbm <- db [tourney_level != 'CH']
dbm <- dbm [match_status != 'Walkover']
#dbm <- dbm [surface =='Clay']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

# Hacemos el merge con stats
dbm <- merge(dbm, pbyp, by = "match_id", all.x = TRUE)

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

dbm <- dbm [year == '2025']

# Para saber los games con mas puntos
resultado <- dbm[,.N,by=c('tourney_name','serve_game','return_game','match_score')]
