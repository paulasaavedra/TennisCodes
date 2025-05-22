library(dplyr)
library(tidyr)
library(data.table)
library(stringr)

dbm <- db [tourney_level != 'CH']
dbm <- dbm [match_status != 'Walkover']

pbyp[, set := fifelse(str_count(match_score, "-") == 1, "primerSet",
                      fifelse(str_count(match_score, "-") == 2, "segundoSet",
                              fifelse(str_count(match_score, "-") == 3, "tercerSet",
                                      fifelse(str_count(match_score, "-") == 4, "cuartoSet",
                                              fifelse(str_count(match_score, "-") == 5, "quintoSet",
                                                      NA_character_)))))]

# Hacemos el merge con stats
dbm <- merge(dbm, pbyp, by = "match_id", all.x = TRUE)

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

# Para saber los games con mas puntos
resultado <- dbm[,.N,by=c('tourney_name','serve_game','return_game','match_score')]


resultado <- dbm[, .(
  puntos = .N,
  break_points = sum(as.numeric(break_point), na.rm = TRUE)
), by = .(tourney_name, serve_game, return_game, set)]
