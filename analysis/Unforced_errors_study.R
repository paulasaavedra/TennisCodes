library(dplyr)
library(tidyr)
library(stringr)


dbm <- db [tourney_level != 'CH']
dbm <- dbm [match_status != 'Walkover']
#dbm <- dbm [surface =='Clay']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

# Merge con stats
dbm <- merge(dbm, db_stats_l_t, by = "match_id", all.x = TRUE)
dbm <- merge(dbm, db_stats_w_t, by = "match_id", all.x = TRUE)

# elijo cuantos sets voy a cosiderar, en este caso 3
dbm <- dbm %>%
  mutate(cantidad_de_sets = str_count(score, "-"))

# Calculo el rate entre puntos jugados y errores no forzados
dbm$w_rate <- dbm$w_t_total_points_played / dbm$w_t_unforced_errors
dbm$l_rate <- dbm$l_t_total_points_played / dbm$l_t_unforced_errors

# calculo winners - ENF
dbm$w_win_enf <- dbm$w_t_winners - dbm$w_t_unforced_errors
dbm$l_win_enf <- dbm$l_t_winners - dbm$l_t_unforced_errors

# jugadores que ganaron/ perdieron partidos de 3 sets con 65 ENF

# Crear el data.table de ganadores
ganadores <- dbm[cantidad_de_sets == 3 & w_t_unforced_errors > 64,
                 .(tourney_level, round_match, date_match,
                   player = w_player,
                   total_points_played = w_t_total_points_played,
                   unforced_errors = w_t_unforced_errors,
                   winners = w_t_winners,
                   rate = w_rate,
                   win_enf = w_win_enf)]

# Crear el data.table de perdedores
perdedores <- dbm[cantidad_de_sets == 3 & l_t_unforced_errors > 64,
                  .(tourney_level, round_match, date_match,
                    player = l_player,
                    total_points_played = l_t_total_points_played,
                    unforced_errors = l_t_unforced_errors,
                    winners = l_t_winners,
                    rate = l_rate,
                    win_enf = l_win_enf)]

# Unir los dos data.tables
jugadores <- rbind(ganadores, perdedores)