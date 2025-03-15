
library (zoo)

# Filtrar el data.table eliminando ciertos torneos
dbm <- db[match_status != 'Walkover' & date_match > "2024-12-25"]
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

# Trabajo con el ranking
rank[, date_rank := as.Date(date_rank, format="%d/%m/%Y")]

rank <- rank [date_rank > "2024-12-01" & rank_position < 101 ]

# Expandir el rango de fechas hasta hoy
rank_expanded <- rank[, .(date_rank = seq(min(date_rank), Sys.Date(), by = "day")), by = player]

# Hacemos un join con el datatable original para obtener los valores de las columnas correspondientes
rank_expanded <- merge(rank_expanded, rank, by = c("player", "date_rank"), all.x = TRUE)

# Rellenamos los valores faltantes con la última observación disponible
rank_expanded[, `:=`(
  rank_position = zoo::na.locf(rank_position, na.rm = FALSE),
  rank_change = zoo::na.locf(rank_change, na.rm = FALSE),
  country = zoo::na.locf(country, na.rm = FALSE),
  player_id = zoo::na.locf(player_id, na.rm = FALSE),
  player = zoo::na.locf(player, na.rm = FALSE),
  age = zoo::na.locf(age, na.rm = FALSE),
  points = zoo::na.locf(points, na.rm = FALSE),
  points_change = zoo::na.locf(points_change, na.rm = FALSE),
  tourney_played = zoo::na.locf(tourney_played, na.rm = FALSE),
  dropping = zoo::na.locf(dropping, na.rm = FALSE),
  next_best = zoo::na.locf(next_best, na.rm = FALSE)
)]

rank_expanded <- as.data.table(rank_expanded)

# Crear versiones en minúsculas solo para el merge
rank_expanded[, player_lower := tolower(player)]
dbm[, w_player_lower := tolower(w_player)]
dbm[, l_player_lower := tolower(l_player)]

# Merge para agregar w_rank sin afectar el formato original
dbm <- merge(dbm, rank_expanded[, .(date_rank, player_lower, rank_position)], 
             by.x = c("date_match", "w_player_lower"), 
             by.y = c("date_rank", "player_lower"), 
             all.x = TRUE)

# Renombrar la columna rank_position a w_rank
setnames(dbm, "rank_position", "w_rank")

# Merge para agregar l_rank sin afectar el formato original
dbm <- merge(dbm, rank_expanded[, .(date_rank, player_lower, rank_position)], 
             by.x = c("date_match", "l_player_lower"), 
             by.y = c("date_rank", "player_lower"), 
             all.x = TRUE)

# Renombrar la columna rank_position a l_rank
setnames(dbm, "rank_position", "l_rank")

# Eliminar solo las columnas temporales sin modificar los nombres originales
dbm[, c("w_player_lower", "l_player_lower") := NULL]
rank_expanded[, player_lower := NULL]


ganados <- dbm[l_rank < 101]
perdidos <- dbm[w_rank < 101]

ganados <- ganados[,.N, by = c('w_player','w_nac')]
perdidos <- perdidos[,.N, by = c('l_player', 'l_nac')]

# Nombrar columnas con "Jugador" y "Ganados" "Perdidos"
names(ganados)[1] <- names(perdidos)[1] <- "Jugador"
names(ganados)[2] <- names(perdidos)[2] <- "Pais"
names(ganados)[3] <- "Ganados"
names(perdidos)[3] <- "Perdidos"

# Unir resultados por nombre
resultados <- merge(ganados, perdidos, by = c("Jugador","Pais"), all=TRUE)

# Poner 0 a los que tienen NA
resultados[is.na(resultados)] <- 'NO'

# sumar ganados y perdidos en una misma columna llamada "Jugados"
resultados <- resultados[, Jugados:=Ganados+Perdidos]
#resultados <- resultados[Jugados>4]

resultados <- resultados[, PorGan:=resultados$Ganados*100/resultados$Jugados]
resultados <- resultados[, PorPer:=resultados$Perdidos*100/resultados$Jugados]

names(resultados)[6] <- "% ganados"
names(resultados)[7] <- "% perdidos"