library(dplyr)
library(tidyr)
library(data.table)
library(lubridate)

dbm <- db[round_match == "SF" & tourney_level == "CH" & w_nac == "Argentina"]
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

# Si todavía no es Date, lo convertís
dbm[, date_match := as.Date(date_match)]

por_semana <- dbm

# Creamos una columna de "semana"
por_semana[, semana := floor_date(date_match, "week", week_start = 1)] 
# week_start=1 hace que la semana empiece el lunes (puede ser 7 si querés domingo)

# Ahora contás por semana
agrupado_por_semana <- por_semana[, .N, by = semana][order(semana)]

# Ahora contás por semana
agrupado_por_semana_torneo <- por_semana[, .N, by = c('semana','tourney_name')][order(semana)]