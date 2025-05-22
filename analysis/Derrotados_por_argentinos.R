library(dplyr)
library(tidyr)
library(kableExtra)


dbm <- db [tourney_level != 'CH']
#dbm <- dbm [date_match> "2025-01-01"]
dbm <- dbm [match_status != 'Walkover']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

derrotas_totales <- dbm [,.N,by=c('l_player')]
dbm <- dbm [w_nac == 'Argentina']
derrotas_argentinas <- dbm [,.N,by=c('l_player')]

# Renombrar columnas
setnames(derrotas_totales, old = c("l_player", "N"), new = c("Jugador", "Derrotas totales"))
setnames(derrotas_argentinas, old = c("l_player", "N"), new = c("Jugador", "Derrotas argentinas"))

# Unir por Jugador (left join de derrotas_argentinas con derrotas_totales)
derrotas_finales <- merge(derrotas_argentinas[, .(Jugador, `Derrotas argentinas`)],
                          derrotas_totales[, .(Jugador, `Derrotas totales`)],
                          by = "Jugador", all.x = TRUE)

derrotas_finales[, `% derrotas argentinas` := round(`Derrotas argentinas` / `Derrotas totales` * 100, 1)]

