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

dbm <- dbm [year==2025]
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


### Para ver el detalle de quien perdió contra quien

# Tabla detallada: quién perdió contra qué campeón y en qué torneo
tabla_detallada <- partidos_campeones %>%
  select(year, id, tourney_name, l_player, campeon, round_match)

# Si quieres que aparezca una fila por cada partido:
tabla_detallada <- tabla_detallada %>%
  arrange(year, id, l_player)

# Si prefieres un resumen (cuántas veces perdió cada jugador contra cada campeón en cada torneo):
tabla_resumen <- tabla_detallada %>%
  group_by(year, tourney_name, l_player, campeon) %>%
  summarise(veces = n(), .groups = "drop") %>%
  arrange(desc(veces))
