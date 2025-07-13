library(dplyr)
library(tidyr)
library(data.table)


dbm <- db [as.Date(date_match, format = "%Y-%m-%d") > as.Date("2024-12-20")]


dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

# Paso 1: Filtrar solo las rondas de qualy
dt_qualy <- dbm[grepl("^Q[1-9]$", round_match)]

# Paso 2: Encontrar la última ronda de qualy por torneo
dt_qualy[, max_qualy_round := max(round_match), by = id]

# Paso 3: Filtrar los partidos de la última ronda de qualy de cada torneo
dt_last_qualy <- dt_qualy[round_match == max_qualy_round]

# Paso 4: Obtener los ganadores (los que pasaron a main draw)
clasificados <- dt_last_qualy[, .(player = w_player, id, tourney_name, tourney_level)]

clasificados_por_jugador <- clasificados [,.N,by=c('player','tourney_level')]