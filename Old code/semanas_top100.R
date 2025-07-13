# Primero me quedo con los argentinos y que fueron top 100
auxi <- rank
rank <- rank [country == 'ARG' &  rank_position<101]

library (zoo)
rank[, date_rank := as.Date(date_rank, format="%d/%m/%Y")]

# Creamos una lista de todas las fechas posibles para cada jugador
rank_expanded <- rank[, .(date_rank = seq(min(date_rank), max(date_rank), by = "day")), by = player]

# Hacemos un join con el datatable original para obtener los valores de las columnas correspondientes
rank_expanded <- merge(rank_expanded, rank, by = c("player", "date_rank"), all.x = TRUE)

# Ahora rellenamos las filas faltantes con los valores de la fecha anterior
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

dias <- rank_expanded[rank_position<26]
dias <- dias[,.N,by=player]

dias[, semanas := round(N / 7,2)]
dias[, años := N / 365]