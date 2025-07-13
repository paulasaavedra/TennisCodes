# Asegurémonos de que ambas tablas están ordenadas por player y date_rank (en rank)
setorder(rank, player, date_rank)

# Función para obtener la edad más cercana para cada jugador y fecha
dbm[, closest_age := {
  # Filtramos los datos de rank para el jugador actual
  player_rank <- rank[player == w_player]
  
  # Calculamos la diferencia de fechas en días y seleccionamos la edad más cercana
  closest_row <- player_rank[which.min(abs(as.Date(date_match) - as.Date(date_rank))), ]
  
  # Devolvemos la edad más cercana
  closest_row$age
  
}, by = w_player]


