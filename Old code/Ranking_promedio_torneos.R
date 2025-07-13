library(data.table)

# Filtrar el data.table eliminando ciertos torneos
dbm <- db[tourney_level != 'CH' & tourney_level != 'DC' & date_match > '2024-12-12']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']


# Crear la columna tourney_id a partir de match_id
dbm[, tourney_id := sub("(_[^_]*)$", "", match_id)]

ganados <- dbm[,.N, by = c('tourney_id', 'w_player', 'w_nac', 'date_match')]
perdidos <- dbm[,.N, by = c('tourney_id', 'l_player', 'l_nac', 'date_match')]

names(ganados)[1] <- names(perdidos)[1] <- "ID_Torneo"
names(ganados)[2] <- names(perdidos)[2] <- "Jugador"
names(ganados)[3] <- names(perdidos)[3] <- "Pais"
names(ganados)[4] <- names(perdidos)[4] <- "Fecha"
names(ganados)[5] <- "Ganados"
names(perdidos)[5] <- "Perdidos"

# Unir resultados por nombre
resultados <- merge(ganados, perdidos, by = c('ID_Torneo','Jugador','Pais', 'Fecha'), all=TRUE)

# Poner 0 a los que tienen NA
resultados[is.na(resultados)] <- 0

resultados$Jugados <- resultados$Ganados + resultados$Perdidos



# Para cargar el ranking
# Asegurémonos de que ambas tablas están ordenadas por player y date_rank (en rank)
setorder(rank, player, date_rank)

# Función para obtener la edad más cercana para cada jugador y fecha, asegurando que date_rank <= Fecha
resultados[, closest_rank := {
  # Filtramos los datos de rank para el jugador actual y donde date_rank <= Fecha
  player_rank <- rank[player == Jugador & date_rank <= Fecha]
  
  # Si hay datos disponibles, seleccionamos el más cercano
  if (nrow(player_rank) > 0) {
    closest_row <- player_rank[which.min(abs(as.Date(Fecha) - as.Date(date_rank))), ]
    closest_row$rank_position
  } else {
    NA  # Si no hay datos, asignamos NA
  }
}, by = Jugador]


# Para obtener promedio / mediana de ranking por torneo
rank_stats <- resultados[, .(
  mean_closest_rank = mean(closest_rank, na.rm = TRUE),
  median_closest_rank = median(closest_rank, na.rm = TRUE),
  min_closest_rank = min(closest_rank, na.rm = TRUE),
  max_closest_rank = max(closest_rank, na.rm = TRUE)
), by = ID_Torneo]

# aca me traigo nombre y nivel del torneo

dbm_unique <- unique(dbm[, .(tourney_id, tourney_name, tourney_level)])

rank_stats <- merge(rank_stats, dbm_unique, 
                    by.x = "ID_Torneo", by.y = "tourney_id", 
                    all.x = TRUE)


