library(dplyr)
library(stringr)
library(data.table)
library(tidyr)

# Definir el id de referencia (por ejemplo, de un partido clave)
id_referencia <- "1536"

# Filtrar los partidos (sin challengers, sin walkovers ni qualies)
tennis_data <- db[tourney_level != 'CH' & match_status != 'Walkover']
#tennis_data <- tennis_data[w_nac %in% paises_latinos] 
tennis_data <- tennis_data[!round_match %in% c('Q1', 'Q2', 'Q3')]

# Limpiar y separar match_id
tennis_data[, match_id := sub("_\\d+$", "", match_id)]
tennis_data <- tennis_data %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(tennis_data)
tennis_data[, id := as.character(id)]

# Filtrar el partido de referencia
partido_ref <- tennis_data[id == id_referencia]

# Obtener los años en los que ocurrió el partido de referencia
years <- unique(partido_ref$year)

# Si el año actual no está en los años, lo agregamos para traer todos los partidos de ese año
año_actual <- format(Sys.Date(), "%Y")
if (!(año_actual %in% years)) {
  years <- c(years, año_actual)
}

# DataFrame para acumular los partidos previos
new_data <- data.frame()

# Iterar por cada año
for (y in years) {
  # Obtener la fecha del partido de referencia para ese año (si existe)
  ref_date <- partido_ref[year == y, max(date_match, na.rm = TRUE)]
  
  # Si no hay partido de referencia, traer todos los partidos del año
  if (is.na(ref_date)) {
    message(paste("No hay partido de referencia para el año", y, "- trayendo todos los partidos del año."))
    filtered_data <- tennis_data[year == y]
  } else {
    filtered_data <- tennis_data %>%
      filter(year == y &
               date_match >= as.Date(paste0(y, "0101"), format = "%Y%m%d") &
               date_match < ref_date)
  }
  
  new_data <- rbind(new_data, filtered_data)
}

# Agrupar por año, jugador e IOC del ganador
agrupados <- as.data.table(new_data)[, .N, by = c("year", "w_player", "w_nac")]


# Aca calculo los triunfos del año actual, si es que aun no paso el torneo
dbm <- db [tourney_level != 'CH' & match_status != 'Walkover' ]

dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

#Filtra una fecha
dbm <- dbm [as.Date(date_match, format = "%Y-%m-%d") > as.Date("2024-12-20")]

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

match_wins <- dbm[,.N,by= c("year", "w_player", "w_nac")]

final_data <- rbind(match_wins, agrupados)


paises_latinos <- c(
  "Argentina", "Brazil", "Chile", "Colombia", "Uruguay", "Paraguay", 
  "Peru", "Ecuador", "Venezuela", "Mexico", "Bolivia", "Guatemala", 
  "Honduras", "El Salvador", "Nicaragua", "Costa Rica", "Panama", 
  "Cuba", "Dominican Republic", "Puerto Rico"
)
dbm <- db[w_nac %in% paises_latinos] 

