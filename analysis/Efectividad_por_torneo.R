library(dplyr)
library(tidyr)


dbm <- db [tourney_level != 'CH' & match_status != 'Walkover' & tourney_level=='M1000']

dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

#Filtra una fecha
dbm <- dbm [as.Date(date_match, format = "%Y-%m-%d") > as.Date("1990-01-01")]

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

ganados <- dbm[,.N, by = c('tourney_name','w_player')]
perdidos <- dbm[,.N, by = c('tourney_name','l_player')]

# Nombrar columnas con "Jugador" y "Ganados" "Perdidos"
names(ganados)[1] <- names(perdidos)[1] <- "id"
names(ganados)[2] <- names(perdidos)[2] <- "Jugador"
names(ganados)[3] <- "Ganados"
names(perdidos)[3] <- "Perdidos"

# Unir resultados por nombre
resultados <- merge(ganados, perdidos, by = c('id', 'Jugador'), all=TRUE)

# Poner 0 a los que tienen NA
resultados[is.na(resultados)] <- 0

# sumar ganados y perdidos en una misma columna llamada "Jugados"
resultados <- resultados[, Jugados:=Ganados+Perdidos]
#resultados <- resultados[Jugados>4]

resultados <- resultados[, PorGan:=resultados$Ganados*100/resultados$Jugados]
resultados <- resultados[, PorPer:=resultados$Perdidos*100/resultados$Jugados]

names(resultados)[6] <- "% ganados"
names(resultados)[7] <- "% perdidos"

# Para traerme los nombres de los torneos

# Obtener solo el último tourney_name y tourney_level por id
tourney_info <- dbm %>%
  group_by(id) %>%
  slice_tail(n = 1) %>%  # Tomar el último registro por id
  select(id, tourney_name, tourney_level) %>%  # Conservar solo las columnas necesarias
  ungroup()

# Unir solo las columnas tourney_name y tourney_level a resultados
resultados <- resultados %>%
  left_join(tourney_info, by = "id")


# Para quedarme con los jugadores con mayor % por torneo:
resultados <- resultados [Jugados>10 ]

resultados_max <- resultados %>%
  group_by(id) %>%
  filter(`% ganados` == max(`% ganados`)) %>%  # Filtra los jugadores con el máximo % de victorias
  ungroup()
