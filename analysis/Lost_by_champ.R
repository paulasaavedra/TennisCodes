library(dplyr)
library(tidyr)
library(data.table)


dbm <- db [tourney_level != 'CH']
dbm <- dbm [match_status != 'Walkover']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

dbm[, match_id := sub("_\\d+$", "", match_id)]
dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

# Paso 1: obtener el campeón de cada torneo (jugador que ganó la final)
campeones <- dbm[round_match == "F", .(campeon = w_player), by = .(year, id)]

# Paso 2: unir con la tabla original para quedarte solo con los partidos donde jugó el campeón
# Es decir, partidos donde el campeón fue w_player o l_player en ese torneo
partidos_campeones <- merge(dbm, campeones, by = c("year", "id"))[
  w_player == campeon | l_player == campeon
]

######## Considerando por año

lose_by_year <- partidos_campeones [,.N,by=c('year','l_player','l_nac')]

derrotas_totales <- dbm[, .(total_losses = .N), by = .( year, l_player)]

lose_by_year <- merge(
  lose_by_year,
  derrotas_totales,
  by.x = c("year", "l_player"),
  by.y = c("year", "l_player"),
  all.x = TRUE
)

lose_by_year$Perc <- lose_by_year$N / lose_by_year$total_losses *100


#### Considernando el total
lose_by_year <- partidos_campeones [,.N,by=c('l_player','l_nac')]

derrotas_totales <- dbm[, .(total_losses = .N), by = .( l_player)]

lose_by_year <- merge(
  lose_by_year,
  derrotas_totales,
  by.x = c( "l_player"),
  by.y = c( "l_player"),
  all.x = TRUE
)

lose_by_year$Perc <- lose_by_year$N / lose_by_year$total_losses *100