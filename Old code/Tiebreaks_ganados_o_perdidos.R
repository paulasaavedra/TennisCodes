library(dplyr)
library(tidyr)
library(data.table)
library (stringr)

dbm <- db [tourney_level!='CH']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']
dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)

dbm[, match_score_clean := gsub("\\(\\d+\\)", "", score)]

# Contar cuántos sets ganados fueron 7-6 (tiebreaks ganados)
dbm[, tb_wins := lengths(regmatches(match_score_clean, gregexpr("7-6", match_score_clean)))]
#tiebreak_ganados <- dbm [w_nac =='Argentina' & tb_wins > 1]


# Contar tiebreaks jugados

dbm[, w_tiebreak := str_count(match_score_clean, "7-6")]
dbm[, l_tiebreak := str_count(match_score_clean, "6-7")]

dbm <- dbm [year == "2025"]
dbm[, w_tb_ganados := str_count(match_score_clean, "\\b7-6\\b")]
dbm[, w_tb_perdidos := str_count(match_score_clean, "\\b6-7\\b")]
dbm[, l_tb_ganados := w_tb_perdidos]
dbm[, l_tb_perdidos := w_tb_ganados]

# Ganador del partido
tb_winner <- dbm[, .(jugador = w_player,
                     tiebreaks_ganados = w_tb_ganados,
                     tiebreaks_perdidos = w_tb_perdidos)]

# Perdedor del partido
tb_loser <- dbm[, .(jugador = l_player,
                    tiebreaks_ganados = l_tb_ganados,
                    tiebreaks_perdidos = l_tb_perdidos)]

# Combinar y agrupar
tiebreaks_por_jugador <- rbind(tb_winner, tb_loser)[, .(
  tiebreaks_ganados = sum(tiebreaks_ganados, na.rm = TRUE),
  tiebreaks_perdidos = sum(tiebreaks_perdidos, na.rm = TRUE)
), by = jugador]

# Calcular totales y porcentaje
tiebreaks_por_jugador[, tiebreaks_jugados := tiebreaks_ganados + tiebreaks_perdidos]
tiebreaks_por_jugador[, pct_tiebreaks_ganados := 
                        fifelse(tiebreaks_jugados > 0,
                                round(100 * tiebreaks_ganados / tiebreaks_jugados, 1),
                                NA_real_)]