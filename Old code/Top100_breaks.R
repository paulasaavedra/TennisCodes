# Para saber edad y paises en que ingresaron al top 100
library(data.table)

dbm <- rank [rank_position < 160]


dbm <- dbm[, .SD[c(1)], by=player]

# Reemplazar comas por puntos y convertir a numérico
dbm[, points := as.numeric(gsub(",", "", points))]

dbm[, year := as.integer(substr(date, 1, 4))]

players_by_year <- dbm[,.N,by=year]
players_by_country_year <- dbm[, .N, by = .(country, year)]
setnames(players_by_country_year, "N", "player_count")  # Renombrar columna para claridad


# Escribir el data.table como archivo Excel
fwrite(dbm, file = "C:/Users/Paula/Documents/Projects/DaveMiley/jugadores_por_pais.csv")


library(dplyr)
library(lubridate)

# 1. Tomamos la tabla dbm (primer ingreso al top200)
# Suponiendo que dbm ya tiene solo la primera vez que cada jugador fue top200

# 2. De rank sacamos la primera posición de cada jugador en el año del debut
rank_inicio <- rank %>%
  mutate(year = year(date_rank)) %>%
  group_by(player, year) %>%
  filter(date_rank == min(date_rank)) %>%
  summarise(first_rank_pos = rank_position, .groups = "drop")

# 3. Ahora unimos con dbm
debut200 <- dbm %>%
  mutate(year = year(date_rank)) %>%
  left_join(rank_inicio, by = c("player", "year")) %>%
  select(
    player,
    country,
    debut_date = date_rank,
    debut_rank = rank_position,
    first_rank_year = first_rank_pos,
    age
  )

debut200$posiciones <- debut200$first_rank_year - debut200$debut_rank
