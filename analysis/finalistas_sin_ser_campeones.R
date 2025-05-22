library(dplyr)
library(tidyr)



dbm <- db [tourney_level != 'CH']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

semis <- dbm [round_match == 'SF']
semis <- semis [,.N,by=c('w_player','w_nac')]

campeones <- dbm [round_match=='F']
campeones <- campeones [,.N,by=c('w_player','w_nac')]

semis_sin_campeones <- semis[!w_player %in% campeones$w_player]
