library(data.table)
library(lubridate)

rank_db <- rank

# ======================================
# Función principal
# ======================================
proyeccion_ranking <- function(rank_db, player_name, tournament_date, tournament_name, point_table) {
  
  # ---- Normalizo tipos de datos ----
  rank_db[, date := as.Date(date_rank)]
  tournament_date <- as.Date(tournament_date)
  
  # ---- 1. Puntos actuales del jugador ----
  # Se usa el ranking más reciente ANTES del torneo
  current_points <- rank_db[player == player_name & date < tournament_date][
    order(-date)][1, points]
  
  if (is.na(current_points)) stop("No hay ranking reciente para ese jugador.")
  
  # ---- 2. Puntos que defiende (año anterior) ----
  last_year_date <- tournament_date - 365
  
  defended_points <- rank_db[
    player == player_name &
      abs(as.numeric(date - last_year_date)) <= 7 &  # ventana +/- 7 días
      grepl(tournament_name, tournament, ignore.case = TRUE),
    sum(points_change, na.rm = TRUE)
  ]
  
  if (is.na(defended_points)) defended_points <- 0
  
  # ---- 3. Proyección por ronda ----
  # point_table debe tener columna "round" y "points_win"
  projections <- point_table[, {
    new_points <- current_points - defended_points + points_win
    
    # Ranking proyectado = posición que tendría con ese total
    # Busco ranking real de esa semana (la del torneo)
    ranking_week <- rank_db[date == max(rank_db[date <= tournament_date]$date),
                            .(player, points)]
    
    ranking_week[, projected_rank := frank(-points, ties.method = "min")]
    
    new_rank <- ranking_week[points <= new_points, min(projected_rank, na.rm = TRUE)]
    if (is.infinite(new_rank)) new_rank <- max(ranking_week$projected_rank)
    
    list(
      round = round,
      sum_points = points_win,
      defended_points = defended_points,
      new_total = new_points,
      new_rank = new_rank
    )
  }]
  
  return(list(
    jugador = player_name,
    torneo = tournament_name,
    fecha = tournament_date,
    puntos_actuales = current_points,
    puntos_defiende = defended_points,
    proyecciones = projections
  ))
}

# ======================================
# Tabla de puntos de ejemplo
# Cambiala según Slam / M1000 / 500 / 250
# ======================================
point_table_atp250 <- data.table(
  round = c("R1", "R2", "QF", "SF", "F", "W"),
  points_win = c(0, 25, 50, 100, 165, 250)
)


resultado <- proyeccion_ranking(
  rank_db = rank_db,
  player_name = "Francisco Cerundolo",
  tournament_date = "2025-04-10",
  tournament_name = "Marrakech",
  point_table = point_table_atp250
)

resultado$proyecciones
