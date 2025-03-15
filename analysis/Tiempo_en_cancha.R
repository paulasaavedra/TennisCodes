
# Filtrar el data.table eliminando ciertos torneos
dbm <- db[tourney_level != 'CH' & match_status != 'Walkover']
#dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

dbm[, match_id := sub("_\\d+$", "", match_id)]

ganados <- dbm [,.N,by=c('match_id','tourney_name','w_player','w_nac','time_total', 'round_match' )]
perdidos <- dbm [,.N,by=c('match_id','tourney_name','l_player','l_nac','time_total', 'round_match' )]



# Nombrar columnas con "Jugador" y "Ganados" "Perdidos"
names(ganados)[1] <- names(perdidos)[1] <- "tourney_id"
names(ganados)[2] <- names(perdidos)[2] <- "tourney_name"
names(ganados)[3] <- names(perdidos)[3] <- "jugador"
names(ganados)[4] <- names(perdidos)[4] <- "pais"
names(ganados)[5] <- names(perdidos)[5] <- "tiempo"
names(ganados)[7] <- "Ganados"
names(perdidos)[7] <- "Perdidos"

ganados <- ganados[, .(TG = sum(tiempo, na.rm = TRUE), PG = .N), 
                   by = .(tourney_id, tourney_name, jugador, pais)]


perdidos <- perdidos[, .(TP = sum(tiempo, na.rm = TRUE), PP = .N), 
                   by = .(tourney_id, tourney_name, jugador, pais)]


# Unir ambos data.tables por las columnas comunes
resultados <- merge(ganados[, .(tourney_id, tourney_name, jugador, pais, PG, TG)], 
                    perdidos[, .(tourney_id, tourney_name, jugador, pais, PP,  TP)], 
                    by = c("tourney_id", "tourney_name", "jugador", "pais"), 
                    all = TRUE)

resultados[is.na(resultados)] <- 0

resultados$TT <- resultados$TG + resultados$TP
resultados$PJ <- resultados$PG + resultados$PP