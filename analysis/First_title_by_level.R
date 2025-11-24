library(dplyr)
library(tidyr)
library(data.table)

dbm <- db[round_match == 'F']

finals <- dbm

# Ordenar por jugador, categoría y fecha
setorder(finals, w_player, tourney_level, date_match)

# Para cada jugador y categoría, tomar su PRIMER título
primer_titulo_cat <- finals[, .SD[1], by = .(w_player, tourney_level)]

primer_titulo_2025 <- primer_titulo_cat[format(date_match, "%Y") == "2025"]

primer_titulo_atp <- primer_titulo_2025[tourney_level!='CH']
