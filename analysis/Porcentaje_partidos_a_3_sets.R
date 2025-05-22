library(dplyr)
library(tidyr)
library(stringr)


dbm <- db [ match_status != 'Walkover']

#dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

#Filtra una fecha
dbm <- dbm [as.Date(date_match, format = "%Y-%m-%d") > as.Date("2024-12-18")]

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)

dbm[, count_sets := str_count(score, "-")]

# Filtro los partidos al mejor de 3 sets

tres <- dbm[tourney_level!='GS']

# Completo con 3 la sque me faltan:
tres[best == 0, best := 3]



library(data.table)

# Obtener jugadores únicos
resumen <- unique(c(tres$w_player, tres$l_player))
resumen <- data.table(player = resumen)

# Calcular partidos jugados (w_player + l_player)
total_partidos <- tres[, .N, by = c("w_player", "l_player")]
total_partidos <- melt(total_partidos, measure.vars = c("w_player", "l_player"), value.name = "player")[, .N, by = player]
setnames(total_partidos, "N", "partidos_jugados")

# Calcular partidos jugados a 3 sets (w_player + l_player cuando count_sets == 3)
partidos_3_sets <- tres[count_sets == 3, .N, by = c("w_player", "l_player")]
partidos_3_sets <- melt(partidos_3_sets, measure.vars = c("w_player", "l_player"), value.name = "player")[, .N, by = player]
setnames(partidos_3_sets, "N", "partidos_a_3_sets")

# Unir los datos
resumen <- merge(resumen, total_partidos, by = "player", all.x = TRUE)
resumen <- merge(resumen, partidos_3_sets, by = "player", all.x = TRUE)

# Reemplazar NA por 0 en partidos_a_3_sets
resumen[is.na(partidos_a_3_sets), partidos_a_3_sets := 0]

# Calcular la proporción de partidos a 3 sets sobre el total de partidos jugados
resumen[, prop_partidos_a_3_sets := (partidos_a_3_sets / partidos_jugados) * 100]

resumen <- resumen [partidos_jugados > 4]
