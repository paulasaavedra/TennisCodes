library(dplyr)
library(tidyr)
library(data.table)

dbm <- db
dbm <- dbm[match_status != 'Walkover']
#dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

# Limpia match_id y separa en year + id
dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)
dbm[, id := as.character(id)]
dbm[, year := as.integer(year)]

# Ganados por jugador y año
ganados <- dbm[w_nac == 'Argentina', .N, by = .(year, tourney_level, Jugador = w_player)]
# Perdidos por jugador y año
perdidos <- dbm[l_nac == 'Argentina', .N, by = .(year, tourney_level, Jugador = l_player)]

# Renombrar columnas
setnames(ganados, "N", "Ganados")
setnames(perdidos, "N", "Perdidos")

# Unir resultados por jugador y año
resultados <- merge(ganados, perdidos, by = c("year", "tourney_level", "Jugador"), all = TRUE)

# Reemplazar NAs con 0
resultados[is.na(resultados)] <- 0

# Calcular jugados
resultados[, Jugados := Ganados + Perdidos]

# Calcular porcentajes
resultados[, `% ganados` := round(Ganados * 100 / Jugados, 1)]
resultados[, `% perdidos` := round(Perdidos * 100 / Jugados, 1)]


# Crear tabla resumen de ganados
win_by_year_level <- dcast(
  resultados, 
  year + Jugador ~ tourney_level,       # columnas por tourney_level
  value.var = "Ganados",                # usamos la columna Ganados
  fun.aggregate = sum,                  # sumar Ganados
  fill = 0                              # llenar con 0 si no hay datos
)

# Columna de total de Ganados por jugador
win_by_year_level[, Total := rowSums(.SD), .SDcols = setdiff(colnames(win_by_year_level), c("year","Jugador"))]
