library(dplyr)
library(tidyr)
library(kableExtra)


dbm <- db [tourney_level != 'CH']
dbm <- dbm [match_status != 'Walkover']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

# Filtrar partidos entre compatriotas
dbm_same_nat <- dbm[w_nac == l_nac]

# Contar victorias de cada jugador sobre otro
counts <- dbm_same_nat[, .N, by = .(winner = w_player, loser = l_player, nac = w_nac)]

# Crear clave de rivalidad única (independiente de quién ganó)
counts[, rivalry := paste(pmin(winner, loser), pmax(winner, loser), sep = " vs ")]

# Obtener los nombres de los dos jugadores
counts[, c("player1", "player2") := tstrsplit(rivalry, " vs ", fixed = TRUE)]

# Tabla con victorias de player1 sobre player2
wins1 <- counts[winner == player1 & loser == player2, .(rivalry, nac, player1, player2, wins_A = N)]

# Tabla con victorias de player2 sobre player1
wins2 <- counts[winner == player2 & loser == player1, .(rivalry, wins_B = N)]

# Unir tablas
res <- merge(wins1, wins2, by = "rivalry", all = TRUE)

# Rellenar NA con 0
res[is.na(wins_A), wins_A := 0]
res[is.na(wins_B), wins_B := 0]

# Calcular diferencia
res[, diff := wins_A - wins_B]

# Ordenar por diferencia
setorder(res, -diff)

# Seleccionar columnas finales
res_final <- res[, .(player1, player2, nac, wins_A, wins_B, diff)]


