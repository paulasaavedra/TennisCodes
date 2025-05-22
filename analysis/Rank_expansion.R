library(dplyr)

# Trabajo con el ranking
rank[, date_rank := as.Date(date_rank, format="%d/%m/%Y")]

rank <- rank [age<27 & rank_position<30]

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



# Suponiendo que rank_expanded es tu DataFrame
result <- rank_expanded %>%
  group_by(country, date_rank) %>%
  filter(rank_position == min(rank_position)) %>%
  ungroup()

# Suponiendo que rank_expanded es tu DataFrame
result <- rank_expanded %>%
  group_by(country, date_rank) %>%
  ungroup()


setDT(result)
auxi <- result[,.N,by=c('player','country')]