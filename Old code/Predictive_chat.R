library(data.table)

db <- db [date_match > "2024-12-20"]
dt <- merge(db, db_stats_l_t, by = "match_id", all.x = TRUE)
dt <- merge(dt, db_stats_w_t, by = "match_id", all.x = TRUE)

# Calcular winrate general o por superficie
calcular_winrate <- function(dt, player, surface = NULL, n_recent = NULL) {
  subset_dt <- dt[w_player == player | l_player == player]
  if (!is.null(surface)) {
    filtro_surface <- surface
    dt <- dt[!is.na(get("surface")) & get("surface") == filtro_surface]
  }
  
  if (!is.null(n_recent)) {
    subset_dt <- subset_dt[order(-date_match)][1:min(n_recent, .N)]
  }
  if (nrow(subset_dt) == 0) return(NA)
  wins <- subset_dt[w_player == player, .N]
  total <- nrow(subset_dt)
  return(wins / total)
}

# Calcular promedio de estadísticas técnicas
promedio_stats <- function(dt, player, columnas, surface = NULL) {
  cols_w <- paste0("w_t_", columnas)
  cols_l <- paste0("l_t_", columnas)
  if (!is.null(surface)) {
    filtro_surface <- surface
    dt <- dt[!is.na(surface) & surface == filtro_surface]
  }
  
  dt_w <- dt[w_player == player, ..cols_w]
  dt_l <- dt[l_player == player, ..cols_l]
  setnames(dt_w, gsub("^w_t_", "", names(dt_w)))
  setnames(dt_l, gsub("^l_t_", "", names(dt_l)))
  
  dt_all <- rbind(dt_w, dt_l, fill = TRUE)
  dt_all[, lapply(.SD, mean, na.rm = TRUE)]
}

# Calcular porcentaje de games ganados
calcular_games_winrate <- function(dt, player) {
  won <- dt[w_player == player, sum(w_t_total_games_won, na.rm = TRUE)] +
    dt[l_player == player, sum(l_t_total_games_won, na.rm = TRUE)]
  total <- dt[w_player == player, sum(w_t_total_games_played, na.rm = TRUE)] +
    dt[l_player == player, sum(l_t_total_games_played, na.rm = TRUE)]
  if (total == 0) return(NA)
  return(won / total)
}

# Calcular head-to-head
calcular_h2h <- function(dt, p1, p2) {
  duelos <- dt[(w_player == p1 & l_player == p2) | (w_player == p2 & l_player == p1)]
  if (nrow(duelos) == 0) return(list(h1 = 0, h2 = 0, total = 0))
  h1 <- duelos[w_player == p1, .N]
  h2 <- duelos[w_player == p2, .N]
  list(h1 = h1, h2 = h2, total = nrow(duelos))
}

# Función principal
predecir_lista_partidos_mejorado <- function(dt, partidos, superficie = NULL) {
  columnas_stats <- c("aces", "1st_serve_percentage", "1st_serve_points_won_percentage",
                      "2nd_serve_points_won_percentage", "return_points_won_percentage")
  
  resultado <- rbindlist(lapply(partidos, function(x) {
    jugadores <- unlist(strsplit(x, " - "))
    jh <- jugadores[1]
    ja <- jugadores[2]
    
    # Winrate general
    wr_h <- calcular_winrate(dt, jh, superficie)
    wr_a <- calcular_winrate(dt, ja, superficie)
    if (is.na(wr_h)) wr_h <- calcular_winrate(dt, jh)
    if (is.na(wr_a)) wr_a <- calcular_winrate(dt, ja)
    if (is.na(wr_h)) wr_h <- 0.5
    if (is.na(wr_a)) wr_a <- 0.5
    
    # Forma reciente
    rec_h <- calcular_winrate(dt, jh, n_recent = 10)
    rec_a <- calcular_winrate(dt, ja, n_recent = 10)
    if (is.na(rec_h)) rec_h <- wr_h
    if (is.na(rec_a)) rec_a <- wr_a
    
    # H2H
    h2h <- calcular_h2h(dt, jh, ja)
    h2h_h <- h2h$h1
    h2h_a <- h2h$h2
    h2h_total <- h2h$total
    
    # Games ganados
    gw_h <- calcular_games_winrate(dt, jh)
    gw_a <- calcular_games_winrate(dt, ja)
    if (is.na(gw_h)) gw_h <- 0.5
    if (is.na(gw_a)) gw_a <- 0.5
    
    # Stats técnicas
    s_h <- promedio_stats(dt, jh, columnas_stats, superficie)
    s_a <- promedio_stats(dt, ja, columnas_stats, superficie)
    
    score_h <- 0
    score_a <- 0
    for (col in columnas_stats) {
      val_h <- s_h[[col]]
      val_a <- s_a[[col]]
      if (!is.na(val_h) & !is.na(val_a) & (val_h + val_a) != 0) {
        p_h <- val_h / (val_h + val_a)
        p_a <- val_a / (val_h + val_a)
      } else {
        p_h <- 0.5
        p_a <- 0.5
      }
      score_h <- score_h + p_h
      score_a <- score_a + p_a
    }
    stats_score_h <- score_h / length(columnas_stats)
    stats_score_a <- score_a / length(columnas_stats)
    
    # Ponderación final
    total_h <- (0.25 * wr_h + 0.25 * rec_h + 0.15 * gw_h + 0.2 * stats_score_h + 
                  ifelse(h2h_total > 0, 0.15 * (h2h_h / h2h_total), 0.075))
    total_a <- (0.25 * wr_a + 0.25 * rec_a + 0.15 * gw_a + 0.2 * stats_score_a + 
                  ifelse(h2h_total > 0, 0.15 * (h2h_a / h2h_total), 0.075))
    
    prob_h <- round(total_h / (total_h + total_a), 3)
    prob_a <- round(total_a / (total_h + total_a), 3)
    
    # Resultado
    data.table(
      JH = jh,
      JA = ja,
      WH = prob_h,
      WA = prob_a,
      WR_H = round(wr_h, 3),
      WR_A = round(wr_a, 3),
      REC_H = round(rec_h, 3),
      REC_A = round(rec_a, 3),
      GW_PERC_H = round(gw_h, 3),
      GW_PERC_A = round(gw_a, 3),
      H2H_H = h2h_h,
      H2H_A = h2h_a,
      H2H_TOT = h2h_total
    )
  }))
  
  return(resultado)
}
partidos <- c(
  "Sebastian Baez - Holger Rune",
  "Arthur Fils - Pedro Martinez",
  "Stefanos Tsitsipas - Sebastian Korda"
)


resultados <- predecir_lista_partidos_mejorado(dt, partidos, superficie = "Clay")
