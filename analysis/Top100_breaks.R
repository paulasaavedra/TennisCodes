# Para saber edad y paises en que ingresaron al top 100
library(data.table)

dbm <- rank [rank_position < 101]


dbm <- dbm[, .SD[c(1)], by=player]

# Reemplazar comas por puntos y convertir a numérico
dbm[, points := as.numeric(gsub(",", "", points))]

dbm[, year := as.integer(substr(date, 1, 4))]

players_by_year <- dbm[,.N,by=year]
players_by_country_year <- dbm[, .N, by = .(country, year)]
setnames(players_by_country_year, "N", "player_count")  # Renombrar columna para claridad


# Escribir el data.table como archivo Excel
fwrite(dbm, file = "C:/Users/Paula/Documents/Projects/DaveMiley/jugadores_por_pais.csv")
