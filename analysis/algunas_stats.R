# Filtramos dataset base
db <- db[date_match > "2024-12-20" & tourney_level != 'CH']
db <- db[!round_match %in% c('Q1', 'Q2', 'Q3')]

# Hacemos el merge con stats
db <- merge(db, db_stats_l_t, by = "match_id", all.x = TRUE)
db <- merge(db, db_stats_w_t, by = "match_id", all.x = TRUE)

# Formato long
long <- rbind(
  db[, .(player = w_player,
         win = 1,
         aces = w_t_aces,
         double_faults = w_t_double_faults,
         winners = w_t_winners,
         unforced = w_t_unforced_errors,
         first_serve_pct = w_t_1st_serve_percentage,
         first_serve_won_pct = w_t_1st_serve_points_won_percentage,
         break_points_converted_pct = w_t_break_points_converted_percentage,
         break_points_saved_pct = w_t_break_points_saved_percentage,
         total_points_won = w_t_total_points_won,
         total_points_played = w_t_total_points_played,
         return_points_won = w_t_return_points_won,
         return_points_played = w_t_return_points_played,
         service_games_won = w_t_service_games_won,
         service_games_played = w_t_service_games_played,
         return_games_won = w_t_return_games_won,
         return_games_played = w_t_return_games_played,
         total_games_won = w_t_total_games_won,
         total_games_played = w_t_total_games_played,
         net_points_won = w_t_net_points_won,
         net_points_played = w_t_net_points_won_played,
         distance = w_t_distance_covered_meters,
         match_id)],
  
  db[, .(player = l_player,
         win = 0,
         aces = l_t_aces,
         double_faults = l_t_double_faults,
         winners = l_t_winners,
         unforced = l_t_unforced_errors,
         first_serve_pct = l_t_1st_serve_percentage,
         first_serve_won_pct = l_t_1st_serve_points_won_percentage,
         break_points_converted_pct = l_t_break_points_converted_percentage,
         break_points_saved_pct = l_t_break_points_saved_percentage,
         total_points_won = l_t_total_points_won,
         total_points_played = l_t_total_points_played,
         return_points_won = l_t_return_points_won,
         return_points_played = l_t_return_points_played,
         service_games_won = l_t_service_games_won,
         service_games_played = l_t_service_games_played,
         return_games_won = l_t_return_games_won,
         return_games_played = l_t_return_games_played,
         total_games_won = l_t_total_games_won,
         total_games_played = l_t_total_games_played,
         net_points_won = l_t_net_points_won,
         net_points_played = l_t_net_points_won_played,
         distance = l_t_distance_covered_meters,
         match_id)]
)

# Estadísticas por jugador
stats_por_jugador <- long[, .(
  partidos = .N,
  victorias = sum(win),
  derrotas = .N - sum(win),
  winrate = round(mean(win) * 100, 1),
  
  # Básicas
  aces_por_partido = round(mean(aces, na.rm = TRUE), 1),
  df_por_partido = round(mean(double_faults, na.rm = TRUE), 1),
  winners_por_partido = round(mean(winners, na.rm = TRUE), 1),
  unforced_por_partido = round(mean(unforced, na.rm = TRUE), 1),
  
  # Primer saque
  primer_saque_pct = round(mean(first_serve_pct, na.rm = TRUE), 1),
  puntos_ganados_1er_saque_pct = round(mean(first_serve_won_pct, na.rm = TRUE), 1),
  
  # Segundo saque (estimado)
  puntos_ganados_2do_saque_pct = round(
    mean(100 * (total_points_won - (first_serve_won_pct/100) * total_points_played) /
           (total_points_played - (first_serve_pct/100) * total_points_played), na.rm = TRUE), 1),
  
  # Quiebres
  break_points_convertidos_pct = round(mean(break_points_converted_pct, na.rm = TRUE), 1),
  break_points_salvados_pct = round(mean(break_points_saved_pct, na.rm = TRUE), 1),
  
  # Totales
  puntos_totales_ganados_pct = round(mean(100 * total_points_won / total_points_played, na.rm = TRUE), 1),
  puntos_return_pct = round(mean(100 * return_points_won / return_points_played, na.rm = TRUE), 1),
  juegos_saque_ganados_pct = round(mean(service_games_won / service_games_played * 100, na.rm = TRUE), 1),
  juegos_retorno_ganados_pct = round(mean(return_games_won / return_games_played * 100, na.rm = TRUE), 1),
  juegos_totales_ganados_pct = round(mean(total_games_won / total_games_played * 100, na.rm = TRUE), 1),
  
  # Red y distancia
  net_points_pct = round(mean(net_points_won / net_points_played * 100, na.rm = TRUE), 1),
  distancia_total_m = sum(distance, na.rm = TRUE),
  distancia_promedio_m = round(mean(distance, na.rm = TRUE), 1),
  
  # Marcadores booleanos
  partidos_con_10_aces = sum(aces >= 10, na.rm = TRUE),
  partidos_con_70_pct_primer_saque = sum(first_serve_pct >= 70, na.rm = TRUE),
  
  # Duración promedio del partido
  duracion_promedio_min = round(mean(db[match_id %in% .SD$match_id, time_total], na.rm = TRUE) / 60, 1)
  
), by = player][order(-winrate)]



stats_servicio <- long[, .(
  puntos_ganados_con_servicio_pct = round(
    mean(100 * (total_points_won - return_points_won) / (total_points_played - return_points_played), na.rm = TRUE), 1),
  
  puntos_ganados_1er_saque_pct = round(mean(first_serve_won_pct, na.rm = TRUE), 1),
  
  puntos_ganados_2do_saque_pct = round(
    mean(100 * (total_points_won - (first_serve_pct / 100) * (first_serve_won_pct / 100) * total_points_played) /
           ((1 - first_serve_pct / 100) * total_points_played), na.rm = TRUE), 1),
  
  partidos_con_70_pct_primer_saque = sum(first_serve_pct >= 70, na.rm = TRUE)
), by = player][order(-puntos_ganados_con_servicio_pct)]


stats_servicio[, cor(puntos_ganados_con_servicio_pct, partidos_con_70_pct_primer_saque, use = "complete.obs")]

library(ggplot2)

ggplot(stats_servicio, aes(x = partidos_con_70_pct_primer_saque, y = puntos_ganados_con_servicio_pct)) +
  geom_point(color = "steelblue") +
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed") +
  labs(
    x = "Partidos con ≥70% primer saque",
    y = "% Puntos ganados con el servicio",
    title = "Relación entre consistencia con el primer saque y efectividad total al sacar"
  ) +
  theme_minimal()


library(ggplot2)
library(ggrepel)

ggplot(stats_servicio, aes(x = partidos_con_70_pct_primer_saque, y = puntos_ganados_con_servicio_pct, label = player)) +
  geom_point(color = "steelblue") +
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed") +
  geom_text_repel(size = 3, max.overlaps = 20) +
  labs(
    x = "Partidos con ≥70% de primeros saques",
    y = "% de puntos ganados con el servicio",
    title = "¿Hay relación entre sacar muchos primeros y ganar más puntos con el saque?"
  ) +
  theme_minimal()


# Filtrar top 10 jugadores con más partidos jugados
top10_jugadores <- stats_por_jugador[order(-partidos)][1:10, player]

# Filtrar stats_servicio solo con esos jugadores
stats_servicio_top10 <- stats_servicio[player %in% top10_jugadores]

# Gráfico con labels solo para top 10
library(ggplot2)
library(ggrepel)

ggplot(stats_servicio_top10, aes(x = partidos_con_70_pct_primer_saque, y = puntos_ganados_con_servicio_pct, label = player)) +
  geom_point(color = "steelblue", size = 3) +
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed") +
  geom_text_repel(size = 3, max.overlaps = 20) +
  labs(
    x = "Partidos con ≥70% de primeros saques",
    y = "% de puntos ganados con el servicio",
    title = "Top 10 en partidos jugados: ¿más primeros saques = más efectividad?"
  ) +
  theme_minimal()


