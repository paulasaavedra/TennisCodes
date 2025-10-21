library(dplyr)
library(data.table)

dbm <- db[tourney_level != 'CH']
dbm <- dbm[match_status != 'Walkover']
dbm <- dbm[!round_match %in% c('Q1', 'Q2', 'Q3')]

dbm[, match_id := sub("_\\d+$", "", match_id)]
dbm <- dbm %>%
  tidyr::separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)
dbm[, id := as.character(id)]

# ---- Rivalidad jugador vs nacionalidad ----

# Victorias del jugador contra nacionalidad del rival
wins_vs_nat <- dbm[, .(wins = .N, player_nat = first(w_nac)), 
                   by = .(player = w_player, nat_rival = l_nac)]

# Derrotas del jugador contra nacionalidad del rival
losses_vs_nat <- dbm[, .(losses = .N, player_nat = first(l_nac)), 
                     by = .(player = l_player, nat_rival = w_nac)]

# Unir tablas
res_nat <- merge(wins_vs_nat, losses_vs_nat, 
                 by = c("player", "nat_rival", "player_nat"), 
                 all = TRUE)

# Rellenar NA con 0
res_nat[is.na(wins), wins := 0]
res_nat[is.na(losses), losses := 0]

# Calcular diferencia
res_nat[, diff := wins - losses]

# Ordenar por diferencia
setorder(res_nat, -diff)

# Resultado final con nacionalidad del jugador
res_nat_final <- res_nat[, .(player, player_nat, nat_rival, wins, losses, diff)]

one_player <- res_nat_final[player == 'Daniil Medvedev']
total_losses <- sum(one_player$losses, na.rm = TRUE)

