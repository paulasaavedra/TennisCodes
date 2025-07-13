library(dplyr)
library(tidyr)
library(stringr)


dbm <- db [tourney_level != 'CH' & match_status != 'Walkover']

dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

#Filtra una fecha
#dbm <- dbm [as.Date(date_match, format = "%Y-%m-%d") > as.Date("2024-12-20")]

# Filtra enero o febrero
#dbm <- dbm[month(as.Date(date_match, format = "%Y-%m-%d")) %in% c(1, 2, 3)]

#dbm <- dbm[grepl("RIO DE J", tourney_name, ignore.case = TRUE)]

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)

# Contar las ocurrencias de "7-6" o "6-7" en cada fila
dbm[, w_tiebreak := str_count(score, "7-6")]
dbm[, l_tiebreak := str_count(score, "6-7")]
dbm[, w_final_tb := ifelse(str_detect(score, "7-6$"), 1, 0)]
dbm[, l_final_tb := ifelse(str_detect(score, "7-6$"), 1, 0)]


ganados <- dbm[, .(year, id, tourney_level, tourney_name, surface, round_match, date_match,
                   w_player, w_nac, w_tiebreak, l_tiebreak, w_final_tb)]
ganados[, result := "win"]

perdidos <- dbm[, .(year, id, tourney_level, tourney_name, surface, round_match, date_match,
                   l_player, l_nac, l_tiebreak, w_tiebreak, l_final_tb )]
perdidos[, result := "lose"]


names(ganados)[8] <- names(perdidos) [8] <- 'jugador'
names(ganados)[9] <- names(perdidos) [9] <- 'nac'
names(ganados)[10] <- names(perdidos) [10] <- 'tb_ganados'
names(ganados)[11] <- names(perdidos) [11] <- 'tb_perdidos'
names(ganados)[12] <- names(perdidos) [12] <- 'final_tb'


# Unir resultados por nombre
resultados <- merge(ganados, perdidos, by = c('year', 'id', 'tourney_level', 'tourney_name',
                                              'surface', 'round_match', 'date_match', 'jugador',
                                              'nac', 'tb_ganados', 'tb_perdidos', 'final_tb','result'), all=TRUE)

# Poner 0 a los que tienen NA
resultados[is.na(resultados)] <- 0


# Crear el datatable 'played_by_year' con las métricas solicitadas
played_by_year <- resultados[, .(
  PG = sum(result == "win"),  # Partidos ganados
  PP = sum(result == "lose"), # Partidos perdidos
  PJ = sum(result %in% c("win", "lose")),  # Partidos jugados (contando win y lose)
  TG = sum(tb_ganados),      # Tiebreaks ganados
  TP = sum(tb_perdidos),     # Tiebreaks perdidos
  TJ = sum(tb_ganados + tb_perdidos), # Tiebreaks jugados (TG + TP)
  TFG = sum(final_tb == 1 & result == "win"), # Tiebreaks finales ganados
  TFP = sum(final_tb == 1 & result == "lose"), # Tiebreaks finales perdidos
  TFJ = sum(final_tb == 1)  # Tiebreaks finales jugados (todos los "SI")
), by = .( jugador, nac)]  # Agrupar por jugador


played_by_year$TG_rate <- played_by_year$TFG / played_by_year$TFJ * 100



