library(dplyr)
library(tidyr)


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

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

# Filtrar por id
# dbm <- dbm[id %in% c( "8996")]



ganados <- dbm[w_nac=='ARG' & l_nac == 'ARG']
perdidos <- dbm[l_nac=='ARG' & w_nac == 'ARG']

ganados <- dbm[,.N, by = w_player]
perdidos <- dbm[,.N, by = l_player]

# Nombrar columnas con "Jugador" y "Ganados" "Perdidos"
names(ganados)[1] <- names(perdidos)[1] <- "Jugador"
names(ganados)[2] <- "Ganados"
names(perdidos)[2] <- "Perdidos"

# Unir resultados por nombre
resultados <- merge(ganados, perdidos, by = c("Jugador"), all=TRUE)

# Poner 0 a los que tienen NA
resultados[is.na(resultados)] <- 0

# sumar ganados y perdidos en una misma columna llamada "Jugados"
resultados <- resultados[, Jugados:=Ganados+Perdidos]
#resultados <- resultados[Jugados>4]

resultados <- resultados[, PorGan:=resultados$Ganados*100/resultados$Jugados]
resultados <- resultados[, PorPer:=resultados$Perdidos*100/resultados$Jugados]

names(resultados)[5] <- "% ganados"
names(resultados)[6] <- "% perdidos"