library(dplyr)
library(tidyr)
library(kableExtra)

dbm <- db [tourney_level != 'CH']
dbm <- dbm [match_status != 'Finished']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]


tourney_uncompleted <- dbm[,.N,by=c('year','id','tourney_name','surface')]