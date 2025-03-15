# Primero me quedo con los partidos del torneo que quiero
dbm <- db [tourney_name == 'Australian Open' & round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

dbm <- dbm [as.Date(date_match, format = "%Y-%m-%d") > as.Date("2024-12-20")]

# Me quedo con las columnas que me interesa analizar
dbm <- dbm[, .(match_id, w_player, w_nac, l_player, l_nac, score, round_match)]

# Me traigo las estadisticas totales del ganador
dbm <- merge(
  dbm, 
  db_stats_w_t[, .(match_id, w_t_aces, w_t_service_points_played)],  
  by = "match_id", 
  all.x = TRUE
)

# Me traigo las estadisticas totales del perdedor
dbm <- merge(
  dbm, 
  db_stats_l_t[, .(match_id, l_t_aces, l_t_service_points_played)],  
  by = "match_id", 
  all.x = TRUE
)

dbm$winrate <- dbm$w_t_aces /dbm$w_t_service_points_played
dbm$losrate <- dbm$l_t_aces /dbm$l_t_service_points_played


# Reorganizo los datos unificando w_player y l_player en una sola columna 'player'
results <- rbind(
  dbm[, .(
    match_id, 
    round_match,
    player = w_player,
    nationality = w_nac,
    role = "win",
    unforced_errors = w_t_aces,
    total_points_played = w_t_service_points_played,
    rate = winrate
  )],
  dbm[, .(
    match_id, 
    round_match,
    player = l_player,
    nationality = l_nac,
    role = "lose",
    unforced_errors = l_t_aces,
    total_points_played = l_t_service_points_played,
    rate = losrate
  )]
)


# Filtrar solo las filas de los jugadores que ganaron
winners <- results[role == "win", .(
  player,
  unforced_errors,
  total_points_played
)]

# Agrupar por jugador y calcular la cantidad de victorias, suma de estadísticas y nuevo winrate
winners_summary <- winners[, .(
  num_wins = .N, # Número de victorias
  total_unforced_errors = sum(unforced_errors, na.rm = TRUE), # Suma de w_t_winners (renombrado como unforced_errors)
  total_points_played = sum(total_points_played, na.rm = TRUE), # Suma de w_t_service_points_played
  winrate = sum(unforced_errors, na.rm = TRUE) / sum(total_points_played, na.rm = TRUE) # Nuevo winrate
), by = player]

# Filtrar jugadores que ganaron al menos 3 partidos
winners_with_3_wins <- winners_summary[num_wins >= 3]

# Resultado final
print(winners_with_3_wins)
