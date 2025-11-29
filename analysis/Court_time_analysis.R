library(dplyr)
library(tidyr)
library(kableExtra)
library(data.table)


dbm <- db [tourney_level != 'CH']
dbm <- dbm [match_status != 'Walkover']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]


# === 0) Copia del dataset original ===
dt <- copy(dbm)


# ============================================================
# === 1) Normalizar: crear una fila por jugador por partido ===
# ============================================================

players_long <- rbind(
  dt[, .(
    year, tourney_name, tourney_level, id,
    player      = w_player,
    player_rank = w_rank,
    t_total     = time_total,
    result      = "W"
  )],
  dt[, .(
    year, tourney_name, tourney_level, id,
    player      = l_player,
    player_rank = l_rank,
    t_total     = time_total,
    result      = "L"
  )]
)
setDT(players_long)



# ============================================================
# === 2) Tiempo promedio en cancha por jugador y por torneo ===
# ============================================================

player_tourney_avg <- players_long[
  , .(
    avg_time = mean(t_total, na.rm = TRUE),
    matches  = .N
  ),
  by = .(player, year, tourney_name)
][order(player, year, tourney_name)]



# ============================================================
# === 3) Duración media de los partidos por torneo ============
# ============================================================

tourney_avg_time <- dt[
  , .(
    tourney_avg_time = mean(time_total, na.rm = TRUE),
    n_matches        = .N
  ),
  by = .(year, tourney_name, tourney_level)
][order(year, tourney_name)]



# ============================================================
# === 4) Detectar jugadores de ALTO DESGASTE ==================
# ===    Regla: estar arriba del percentil 90 del torneo ======
# ============================================================

# Agregar duración promedio del torneo a la tabla long
players_long <- merge(players_long,
                      tourney_avg_time,
                      by = c("year", "tourney_name"),
                      all.x = TRUE)

# Calcular percentil 90 por torneo y marcar "alto desgaste"
players_long[, high_load :=
               t_total > quantile(t_total, 0.90, na.rm = TRUE),
             by = .(year, tourney_name)]

high_load_players <- players_long[high_load == TRUE]



# ============================================================
# === 5) Efecto del desgaste en torneos posteriores ===========
# ===    Comparar promedio del torneo con el siguiente =========
# ============================================================

# Agregar total de desgaste por torneo por jugador
load_per_tourney <- players_long[
  , .(
    high_load_matches = sum(high_load, na.rm = TRUE),
    avg_time          = mean(t_total, na.rm = TRUE)
  ),
  by = .(player, year, tourney_name)
][order(player, year, tourney_name)]

# Crear columna: tiempo promedio en el torneo siguiente
load_per_tourney[, next_avg_time :=
                   shift(avg_time, type = "lead"),
                 by = player]

# Medir diferencia (impacto simple)
load_per_tourney[, effect :=
                   next_avg_time - avg_time]



# ============================================================
# === 6) Resultados principales listos para usar ==============
# ============================================================

# player_tourney_avg  → tiempo promedio por jugador y torneo
# tourney_avg_time    → duración media de partidos por torneo
# high_load_players   → jugadores que tuvieron partidos de alto desgaste
# load_per_tourney    → impacto del desgaste en el siguiente torneo

