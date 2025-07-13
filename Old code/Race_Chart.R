library(data.table)
library(ggplot2)
library(gganimate)
library(dplyr)
library(tidyr)

# Filtrado de datos
dbm <- db[tourney_level != 'CH']
dbm <- dbm[match_status != 'Walkover']
dbm <- dbm[round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

# Extraer año e ID
dbm[, match_id := sub("_\\d+$", "", match_id)]
dbm <- dbm %>% separate(match_id, into = c("year", "id"), sep = "_")
setDT(dbm)
dbm[, id := as.character(id)]

# Filtrar por torneo
dbm <- dbm[id == '0520']

# Partidos ganados por año y jugador
partidos_ganados <- dbm[, .N, by = .(year, w_player)]
partidos_ganados[, year := as.integer(year)]

# Orden y acumulado
setorder(partidos_ganados, w_player, year)
partidos_ganados[, N_acumulado := cumsum(N), by = w_player]

# Top 20 jugadores (para asegurar siempre tener 10 visibles)
top_players <- partidos_ganados[, .(total = max(N_acumulado)), by = w_player][order(-total)][1:100, w_player]
partidos_ganados <- partidos_ganados[w_player %in% top_players]

# Completar datos faltantes (todos los años x top jugadores)
todos_los_anos <- unique(partidos_ganados$year)
completo <- CJ(year = todos_los_anos, w_player = top_players)

# Unir y calcular acumulado
partidos_completos <- merge(completo, partidos_ganados, by = c("year", "w_player"), all.x = TRUE)
setorder(partidos_completos, w_player, year)
partidos_completos[is.na(N), N := 0]
partidos_completos[, N_acumulado := cumsum(N), by = w_player]

# Eliminar jugadores con 0 acumulado hasta ese año
partidos_completos <- partidos_completos[N_acumulado > 0]

# Ranking por año
partidos_completos[, rank := frank(-N_acumulado, ties.method = "first"), by = year]

# Filtrar top 10 por año
partidos_top10 <- partidos_completos[rank <= 30]
# Lista de jugadores destacados
destacados <- c("Rafael Nadal", "Novak Djokovic", "Roger Federer", "Guillermo Vilas")

# Crear columna color
partidos_top10[, color := ifelse(w_player %in% destacados, w_player, "Otros")]

# Definir colores: para los destacados un color cada uno y para "Otros" un gris
colores <- c(
  "Rafael Nadal" = "#E41A1C",    # rojo
  "Novak Djokovic" = "#377EB8",  # azul
  "Roger Federer" = "#4DAF4A",   # verde
  "Guillermo Vilas" = "#9abcdf",
  "Otros" = "grey80"
)
# Crear el gráfico con título y marca de agua
p <- ggplot(partidos_top10, aes(x = -rank, y = N_acumulado, fill = color)) +
  geom_col(width = 0.5, show.legend = FALSE) +
  geom_text(aes(label = paste0(w_player, ": ", N_acumulado)),
            hjust = -0.1, color = "black", size = 4) +
  scale_x_continuous(breaks = -1:-15, labels = NULL) +
  coord_flip(clip = "off") +
  scale_fill_manual(values = colores) +
  labs(
    title = 'Jugadores con más partidos ganados en Roland Garros a través de los años',
    subtitle = 'Año: {closest_state}',
    x = '',
    y = '@argentenista'
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(size = 20, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 16, hjust = 0.5),
    plot.margin = margin(0.5, 3, 0.5, 0.5, "cm"),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    plot.caption = element_text(size = 10, color = "gray40", hjust = 1)
  ) +
  labs(caption = "") +
  transition_states(year, transition_length = 4, state_length = 1) +
  ease_aes('cubic-in-out')

# Animar y guardar
animate(p, nframes = 500, fps = 20, width = 1000, height = 650,
        renderer = gifski_renderer("bar_chart_race_colores_titulo.gif"))
