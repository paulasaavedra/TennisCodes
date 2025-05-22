
dbm <- db [as.Date(date_match, format = "%Y-%m-%d") > as.Date("2024-12-20")]
dbm <- dbm [tourney_level != 'CH']
#dbm <- dbm [ round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']
dbm <- dbm [match_status != 'Walkover' & tourney_name == 'Miami']

# Me quedo con las columnas que me interesa analizar
dbm <- dbm[, .(match_id, w_player, w_nac, l_player, l_nac, score)]

# Me traigo las estadisticas totales del ganador
dbm <- merge(
  dbm, 
  db_stats_w_t[, .(match_id, w_t_aces, w_t_double_faults,w_t_service_points_played,w_t_average_1st_serve_speed, w_t_average_2nd_serve_speed )],  
  by = "match_id", 
  all.x = TRUE
)

# Me traigo las estadisticas totales del perdedor
dbm <- merge(
  dbm, 
  db_stats_l_t[, .(match_id, l_t_aces, l_t_double_faults, l_t_service_points_played, l_t_average_1st_serve_speed, l_t_average_2nd_serve_speed)],  
  by = "match_id", 
  all.x = TRUE
)



# Crear un nuevo data.table con las columnas de los ganadores
winners <- dbm[, .(
  player = w_player,
  nac = w_nac,
  aces = w_t_aces,
  df = w_t_double_faults,
  service_points_plyd = w_t_service_points_played,
  first_speed = w_t_average_1st_serve_speed,
  sec_speed = w_t_average_2nd_serve_speed
)]

# Crear un nuevo data.table con las columnas de los perdedores
losers <- dbm[, .(
  player = l_player,
  nac = l_nac,
  aces = l_t_aces,
  df = l_t_double_faults,
  service_points_plyd = l_t_service_points_played,
  first_speed = l_t_average_1st_serve_speed,
  sec_speed = l_t_average_2nd_serve_speed
  
  
)]

# Combinar ambas tablas, una debajo de la otra
combined <- rbind(winners, losers)
pj <- combined [,.N,by= player]
names(pj) [2] <- 'pj'


# Calcular promedios por jugador
player_avg <- combined[, .(
  sum_aces = sum(aces, na.rm = TRUE),
  sum_df = sum(df, na.rm = TRUE),
  sum_ptos_plyd = sum(service_points_plyd, na.rm = TRUE),
  fist = mean(first_speed),
  second = mean (sec_speed)
), by = player]


player_avg[, (names(player_avg)) := lapply(.SD, function(x) if (is.numeric(x)) round(x) else x)]


player_avg$aces_ptos <- player_avg$sum_aces / player_avg$sum_ptos_plyd
player_avg$df_ptos <- player_avg$sum_df / player_avg$sum_ptos_plyd


# Agrego la cantidad de partidos jugados
results <- merge(
  player_avg, 
  pj[, .(player,pj)],  
  by = "player", 
  all.x = TRUE
)