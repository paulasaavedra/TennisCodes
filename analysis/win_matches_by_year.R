library(dplyr)
library(tidyr)
library(data.table)

dbm <- db[tourney_level != 'CH']
dbm <- dbm[match_status != 'Walkover']
dbm <- dbm[!round_match %in% c('Q1', 'Q2', 'Q3')]

# Limpia match_id y separa en year + id
dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)
dbm[, id := as.character(id)]
dbm[, year := as.integer(year)]

# Ganados por jugador y año
ganados <- dbm[w_nac == 'Argentina', .N, by = .(year, Jugador = w_player)]
# Perdidos por jugador y año
perdidos <- dbm[l_nac == 'Argentina', .N, by = .(year, Jugador = l_player)]

# Renombrar columnas
setnames(ganados, "N", "Ganados")
setnames(perdidos, "N", "Perdidos")

# Unir resultados por jugador y año
resultados <- merge(ganados, perdidos, by = c("year", "Jugador"), all = TRUE)

# Reemplazar NAs con 0
resultados[is.na(resultados)] <- 0

# Calcular jugados
resultados[, Jugados := Ganados + Perdidos]

# Calcular porcentajes
resultados[, `% ganados` := round(Ganados * 100 / Jugados, 1)]
resultados[, `% perdidos` := round(Perdidos * 100 / Jugados, 1)]


# Para cada año, quedate con los 3 jugadores con más triunfos
top3_por_año <- resultados[
  order(-Ganados), 
  head(.SD, 2), 
  by = year
]


# Solo jugadores con al menos 10 victorias en el año
top3_efectividad <- resultados[Ganados >= 10][
  order(-`% ganados`), 
  head(.SD, 3), 
  by = year
]

