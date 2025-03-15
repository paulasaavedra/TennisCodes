

dbm <- db [tourney_name == 'Australian Open' & tourney_level=='ATP']
dbm <- dbm[, if (.N >= 2) .SD, by = w_player]
dbm <- merge(
  dbm, 
  db_stats_w_t[, .(match_id, w_t_aces, w_t_winners,w_t_unforced_errors , w_t_double_faults, w_t_average_1st_serve_speed, w_t_average_2nd_serve_speed,
                   w_t_1st_serve_percentage, w_t_1st_serve_points_won_percentage, w_t_2nd_serve_points_won_percentage,
                   w_t_service_points_won_percentage, w_t_service_games_won_percentage,
                   w_t_total_games_played)],  
  by = "match_id", 
  all.x = TRUE
)


# Calcular promedios por jugador
player_avg <- dbm[, .(
  avg_aces = sum(w_t_aces, na.rm = TRUE),
  avg_win = sum(w_t_winners, na.rm = TRUE),
  avg_unf = sum(w_t_unforced_errors, na.rm = TRUE),
  avg_df = sum(w_t_double_faults, na.rm = TRUE),
  avg_pplayed = sum(w_t_total_games_played, na.rm = TRUE),
  avg_first_serve_percentage = mean(w_t_1st_serve_percentage, na.rm = TRUE),
  avg_first_serve_points_won_percentage = mean(w_t_1st_serve_points_won_percentage, na.rm = TRUE),
  avg_second_serve_points_won_percentage = mean(w_t_2nd_serve_points_won_percentage, na.rm = TRUE),
  avg_serve_points_won_percentage = mean(w_t_service_points_won_percentage, na.rm = TRUE),
  avg_service_games_won_percentage = mean(w_t_service_games_won_percentage, na.rm = TRUE),
  avg_time = sum(time_total, na.rm = TRUE)
), by = w_player]


player_avg_normalized <- player_avg[, lapply(.SD, function(x) x / avg_pplayed), 
                                    by = w_player, 
                                    .SDcols = !c("avg_pplayed")]


player_avg_norm_time <- player_avg[, lapply(.SD, function(x) x / avg_time), 
                                   by = w_player, 
                                   .SDcols = !c("avg_time")]
