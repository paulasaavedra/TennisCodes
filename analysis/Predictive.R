library(data.table)
library(stringr)

# Asegúrate de que todos tengan match_id como columna clave
setkey(db, match_id)
setkey(db_stats_l_t, match_id)
setkey(db_stats_w_t, match_id)

dbm <- db

#db <- db [as.Date(date_match, format = "%Y-%m-%d") > as.Date("2024-12-20")]

# Merge en dos pasos
db_merged <- merge(db, db_stats_l_t, by = "match_id", all.x = TRUE)
db <- merge(db_merged, db_stats_w_t, by = "match_id", all.x = TRUE)


# -------------------------------
# MODELO DE PREDICCIÓN DE TENIS
# Basado en oponentes comunes
# -------------------------------

# 1. Filtrar partidos entre dos jugadores
get_matches_between <- function(player1, player2, data) {
  data[
    (w_player == player1 & l_player == player2) |
      (w_player == player2 & l_player == player1)
  ]
}

# 2. Obtener oponentes comunes con mayor tolerancia
get_common_opponents_v2 <- function(playerA, playerB, data, min_matches = 3) {
  opponents_A <- unique(c(
    data[w_player == playerA, l_player],
    data[l_player == playerA, w_player]
  ))
  opponents_B <- unique(c(
    data[w_player == playerB, l_player],
    data[l_player == playerB, w_player]
  ))
  common_opps <- as.character(intersect(opponents_A, opponents_B))
  
  # Solo devolvemos oponentes que hayan jugado al menos 'min_matches' veces contra los jugadores
  filter_idx <- vapply(common_opps, function(opp) {
    length(get_matches_between(playerA, opp, data)) >= min_matches && 
      length(get_matches_between(playerB, opp, data)) >= min_matches
  }, logical(1))
  
  common_opps_filtered <- common_opps[filter_idx]
  
  
  return(common_opps_filtered)
}

# 3. Calcular Delta_i_AB (ventaja de A vs B contra oponente i)
calc_delta <- function(playerA, playerB, opponent, stat_col, data) {
  get_stat <- function(player, opp, col) {
    win_col <- paste0("w_t_", col)
    loss_col <- paste0("l_t_", col)
    
    wins <- data[w_player == player & l_player == opp, ..win_col][[1]]
    losses <- data[l_player == player & w_player == opp, ..loss_col][[1]]
    
    all_vals <- c(wins, losses)
    if (length(all_vals) == 0 || all(is.na(all_vals))) return(NA)
    
    mean(all_vals, na.rm = TRUE)
  }
  
  
  stat_A <- get_stat(playerA, opponent, stat_col)
  stat_B <- get_stat(playerB, opponent, stat_col)
  delta <- stat_A - stat_B
  return(delta)
}

# 4. Calcular Delta_AB (promedio sobre oponentes comunes)
calc_delta_AB <- function(playerA, playerB, stat_col, data) {
  common_opps <- get_common_opponents_v2(playerA, playerB, data)
  if (length(common_opps) == 0) return(NA)
  deltas <- sapply(common_opps, function(opp) calc_delta(playerA, playerB, opp, stat_col, data))
  mean(deltas, na.rm = TRUE)
}

# 5. Convertir Delta_AB a probabilidad con suavizado
delta_to_prob_v2 <- function(delta) {
  if (is.na(delta)) return(0.5)  # Si no hay delta, asumimos probabilidad 50%
  
  # Si delta es muy extremo, suavizamos la transformación logística
  if (delta > 10) return(0.95)  # Umbral de suavizado
  if (delta < -10) return(0.05) # Umbral de suavizado
  
  # Transformación logística
  1 / (1 + exp(-delta))
}

# 6. Simular un partido al mejor de 3 sets
simulate_M3 <- function(prob_A, n_sim = 1000) {
  wins_A <- replicate(n_sim, {
    sets_A <- 0
    sets_B <- 0
    while (sets_A < 2 & sets_B < 2) {
      if (runif(1) < prob_A) {
        sets_A <- sets_A + 1
      } else {
        sets_B <- sets_B + 1
      }
    }
    sets_A == 2
  })
  mean(wins_A)
}

# 7. Predecir jugador A vs jugador B
predict_match_v2 <- function(playerA, playerB, stat_col = "total_points_won_percentage", data = db) {
  common_opps <- get_common_opponents_v2(playerA, playerB, data)
  if (length(common_opps) == 0) {
    # Si no hay oponentes comunes, usamos la estadística general del jugador
    delta <- calc_delta_AB(playerA, playerB, stat_col, data)
  } else {
    # Si hay oponentes comunes, calculamos el delta considerando oponentes comunes
    delta <- calc_delta_AB(playerA, playerB, stat_col, data)
  }
  
  prob_A <- delta_to_prob_v2(delta)
  winrate_A <- simulate_M3(prob_A)
  set_prob_A <- simulate_set_prob(prob_A)
  
  list(
    playerA = playerA,
    playerB = playerB,
    stat = stat_col,
    delta_AB = delta,
    prob_A = prob_A,
    winrate_A = winrate_A,
    winrate_B = 1 - winrate_A,
    set_win_prob_A = set_prob_A,
    set_win_prob_B = 1 - set_prob_A
  )
}

# Función para simular la probabilidad de que un jugador gane un set
simulate_set_prob <- function(prob_A) {
  prob_A
}

# -------------------------------
# 🔍 Ejemplo de uso
# -------------------------------
resultado <- predict_match_v2("Pedro Martinez", "Brandon Nakashima", stat_col = "total_points_won_percentage")
print(resultado)

# -------------------------------
# 🔍 Ejemplo muchos partidos
# -------------------------------

matches <- data.table(
  playerA = c("Francisco Cerundolo"),
  playerB = c("Jakub Mensik")
)

probabilidades <- rbindlist(lapply(1:nrow(matches), function(i) {
  pA <- matches[i, playerA]
  pB <- matches[i, playerB]
  res <- predict_match_v2(pA, pB, stat_col = "total_points_won_percentage")
  data.table(
    playerA = pA,
    playerB = pB,
    match_win_prob_A = round(res$prob_A, 3),
    match_win_prob_B = round(res$winrate_B, 3),
    set_win_prob_A = round(res$set_win_prob_A, 3),
    set_win_prob_B = round(res$set_win_prob_B, 3)
  )
}))
print(probabilidades)
