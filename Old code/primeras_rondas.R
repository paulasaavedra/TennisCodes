library(data.table)

# 1. Filtramos torneos válidos y quitamos walkovers y qualies
dbm <- db[
  tourney_level != 'CH' &
    match_status != 'Walkover' &
    !round_match %in% c('Q1', 'Q2', 'Q3', 'RR')
]

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

# 2. Definir rondas válidas en orden
rondas_ordenadas <- c("R128", "R64", "R32", "R16", "QF", "SF", "F")

# 3. Filtrar solo partidos con rondas válidas
dbm <- dbm[round_match %in% rondas_ordenadas]

# 4. Crear columna numérica para orden de ronda
dbm[, ronda_orden := match(round_match, rondas_ordenadas)]

# 5. Obtener la ronda más temprana de cada torneo (por id + year)
primeras_rondas_info <- dbm[, .(min_ronda = min(ronda_orden, na.rm = TRUE)), by = .(id, year)]

# 6. Unir para obtener solo los partidos de la ronda más temprana
primeras_rondas <- merge(dbm, primeras_rondas_info, by = c("id", "year"))
primeras_rondas <- primeras_rondas[ronda_orden == min_ronda]

# 7. Eliminar la columna auxiliar si querés
primeras_rondas[, ronda_orden := NULL]


# Buscando argentinos que se enfrentaron a argentinos

duelos_argentinos <- primeras_rondas [w_nac == 'Argentina' & l_nac == 'Argentina']

duelos_por_torneo <- duelos_argentinos [,.N,by=c('year','id','tourney_name')]
duelos_por_torneo <- duelos_por_torneo[N>1]