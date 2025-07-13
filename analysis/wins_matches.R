library(dplyr)
library(tidyr)
library(kableExtra)


dbm <- db [tourney_level != 'CH']
dbm <- dbm [match_status != 'Walkover']
#dbm <- dbm [surface =='Clay']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

#Filtra una fecha
#dbm <- dbm [as.Date(date_match, format = "%Y-%m-%d") > as.Date("2024-12-20")]

# Filtra enero o febrero
#dbm <- dbm[month(as.Date(date_match, format = "%Y-%m-%d")) %in% c(1, 2, 3)]

#dbm <- dbm[grepl("RIO DE J", tourney_name, ignore.case = TRUE)]

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

dbm <- dbm [year=='2025']
#dbm <- dbm [tourney_level=='M1000']

# Filtrar por id
#dbm <- dbm[id %in% c( "0308")]

ganados <- dbm[w_nac == 'Argentina']
perdidos <- dbm[l_nac=='Argentina']

ganados <- dbm[,.N, by = w_player]
perdidos <- dbm[,.N, by = l_player]

# Nombrar columnas con "Jugador" y "Ganados" "Perdidos"
names(ganados)[1] <- names(perdidos)[1] <- "Jugador"
names(ganados)[2] <- "Ganados"
names(perdidos)[2] <- "Perdidos"

# Unir resultados por nombre
resultados <- merge(ganados, perdidos, by = c("Jugador"), all=TRUE)

# Poner 0 a los que tienen NA
resultados[is.na(resultados)] <- 0

# sumar ganados y perdidos en una misma columna llamada "Jugados"
resultados <- resultados[, Jugados:=Ganados+Perdidos]
#resultados <- resultados[Jugados>4]

resultados <- resultados[, PorGan:= round(resultados$Ganados*100/resultados$Jugados, 1)]
resultados <- resultados[, PorPer:= round(resultados$Perdidos*100/resultados$Jugados, 1)]

names(resultados)[5] <- "% ganados"
names(resultados)[6] <- "% perdidos"


#########  Tabla #####################

# Ordenar por % ganados (descendente) y luego por Ganados (descendente)
setorder(resultados, -Ganados,-`% ganados`)

# Tomar los 10 primeros con las columnas deseadas
top10 <- resultados[1:10, .(Jugador, Ganados, `% ganados`)]

# Mostrar la tabla con estilo
tabla <- top10 |>
  kable("html", 
        col.names = c("Jugador", "PG", "% ganados"),
        align = "rccc") |>
  kable_styling(
    full_width = FALSE,
    font_size = 11,
    html_font = "Arial"
  ) |>
  row_spec(0, bold = TRUE, color = "#004c72", background = "#98b8d9") |>  # encabezado
  column_spec(1:ncol(top10), extra_css = "padding-top: 2px; padding-bottom: 2px;")  # 👈 esta línea achica las filas

# Alternar colores manualmente en filas
for (i in 1:nrow(top10)) {
  color_fondo <- ifelse(i %% 2 == 0, "#efece7", "#efece7")
  tabla <- tabla |> row_spec(i, background = color_fondo)
}

tabla <- tabla |>
  #row_spec(3, bold = TRUE, background = "#d6e3f1", extra_css = "font-size: 11px;")|>
  row_spec(3, bold = TRUE, background = "#d6e3f1", extra_css = "font-size: 11px;")

tabla

############# Efectividad Big 3 + Top 10 por torneos grandes ####################

library(dplyr)
library(data.table)
library(tidyr)
library(kableExtra)

# Jugadores de interés
jugadores_filtrados <- c("Rafael Nadal", "Novak Djokovic", "Roger Federer", 
                         "Carlos Alcaraz", "Jannik Sinner", "Daniil Medvedev", 
                         "Jack Draper", "Alexander Zverev", "Taylor Fritz", 
                         "Alex De Minaur", "Andrey Rublev", "Casper Ruud")

# Filtro de fechas
db <- db[as.Date(date_match, format = "%Y-%m-%d") > as.Date("1990-01-01")]

# Torneos a excluir
torneos_excluir <- c("DOHA", "DOHA AUS OPEN QUALIES", "STUTTGART", "HAMBURG")

# Normalización de nombres
db_clean <- copy(db)
setDT(db_clean)
db_clean[, tourney_name := toupper(trimws(tourney_name))]

# Filtrar base
db_filtrada <- db_clean[
  tourney_level %in% c("M1000", "GS") &
    !(tourney_name %in% torneos_excluir) &
    (w_player %in% jugadores_filtrados | l_player %in% jugadores_filtrados)
]

# Partidos ganados por los jugadores
ganados <- db_filtrada[w_player %in% jugadores_filtrados, .(
  Jugador = w_player,
  Torneo = tourney_name,
  Ganado = 1,
  Perdido = 0
)]

# Partidos perdidos por los jugadores
perdidos <- db_filtrada[l_player %in% jugadores_filtrados, .(
  Jugador = l_player,
  Torneo = tourney_name,
  Ganado = 0,
  Perdido = 1
)]

# Unir y calcular efectividad
resultados <- rbind(ganados, perdidos)
resumen <- resultados[, .(
  Ganados = sum(Ganado),
  Perdidos = sum(Perdido)
), by = .(Jugador, Torneo)]
resumen[, Jugados := Ganados + Perdidos]
resumen[, Efectividad := round(Ganados * 100 / Jugados, 1)]

# Pivotear tabla
tabla <- dcast(resumen, Jugador ~ Torneo, value.var = "Efectividad")

# Renombrar columnas principales
col_renombres <- c(
  "AUSTRALIAN OPEN" = "AO",
  "ROLAND GARROS" = "RG",
  "WIMBLEDON" = "WB",
  "US OPEN" = "USO",
  "CINCINNATI" = "CIN",
  "INDIAN WELLS" = "IW",
  "MADRID" = "MAD",
  "MIAMI" = "MIA",
  "MONTE CARLO" = "MC",
  "PARIS" = "PAR",
  "ROME" = "ROM",
  "SHANGHAI" = "SHA",
  "CANADA" = "CAN"
)
nombres_actuales <- names(tabla)
nombres_nuevos <- ifelse(nombres_actuales %in% names(col_renombres), 
                         col_renombres[nombres_actuales], 
                         nombres_actuales)
names(tabla) <- nombres_nuevos

# Reordenar columnas
cols_fijas <- c("Jugador", "AO", "RG", "WB", "USO")
otras_cols <- setdiff(names(tabla), cols_fijas)
tabla <- tabla[, c(cols_fijas, sort(otras_cols)), with = FALSE]

# Funciones de colores
color_gradient <- function(columna) {
  max_val <- max(columna, na.rm = TRUE)
  min_val <- min(columna, na.rm = TRUE)
  escala_color <- colorRampPalette(c("#e0f3db", "#43a2ca"))
  niveles <- 100
  colores <- escala_color(niveles)
  indices <- round((columna - min_val) / (max_val - min_val) * (niveles - 1)) + 1
  colores_finales <- rep("", length(columna))
  colores_finales[!is.na(indices)] <- colores[indices[!is.na(indices)]]
  return(colores_finales)
}

highlight_top <- function(columna, colores) {
  top_idx <- which.max(columna)
  colores[top_idx] <- "#ffd700"  # Dorado para el mejor
  return(colores)
}

# Crear tabla con estilo kable
tabla_kbl <- kbl(
  tabla, 
  format = "html", 
  escape = FALSE, 
  align = "c"
) %>%
  kable_styling(
    full_width = FALSE,
    position = "center",
    font_size = 10,
    html_font = "Arial"
  )

# Aplicar colores por columna (excepto Jugador)
for (col in names(tabla)[-1]) {
  colores <- color_gradient(tabla[[col]])
  colores <- highlight_top(tabla[[col]], colores)
  tabla_kbl <- column_spec(
    tabla_kbl, 
    which(names(tabla) == col), 
    background = colores,
    width = "70px"
  )
}

# Mostrar tabla
tabla_kbl






