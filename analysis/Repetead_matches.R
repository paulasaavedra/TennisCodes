library(dplyr)
library(tidyr)
library(data.table)

dbm <- db

# Limpia match_id y separa en year + id
dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)
dbm[, id := as.character(id)]
dbm[, year := as.integer(year)]

# Creamos columnas auxiliares para identificar el par de jugadores sin importar el orden
dbm[, player1 := pmin(w_player, l_player)]
dbm[, player2 := pmax(w_player, l_player)]

# Contar partidos por torneo (id + year) y par de jugadores
matches_repeated <- dbm[, .N, by = .(year, id, tourney_name, tourney_level, player1, player2)]

# Filtrar los pares que jugaron más de una vez en ese mismo torneo y año
matches_repeated <- matches_repeated[N > 1]