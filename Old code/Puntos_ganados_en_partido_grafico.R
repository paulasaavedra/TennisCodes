library(dplyr)
library(tidyr)
library(ggplot2)

dbm <- db[date_match>"2025-02-01"]
pbyp_tomi <- pbyp [match_id=='2025_0404_084548']
# homre y away
# Separo los puntajes entre p1 y p2
pbyp_tomi <- pbyp_tomi %>%
  separate(game_score, into = c("p1", "p2"), sep = ":", fill = "right", remove = FALSE)

setDT(pbyp_tomi) 
pbyp_tomi[p1 == "A", p1 := "50"]
pbyp_tomi[p2 == "A", p2 := "50"]


pbyp_tomi <- pbyp_tomi %>%
  arrange(point_number)
library(data.table)

# Suponiendo que pbyp_tomi ya es un data.table y está ordenado en orden cronológico
pbyp_tomi[, point_winner := ifelse(
  (shift(p1, type = "lag") < p1) |  # Regla 1: P1 gana si su valor actual es mayor que el anterior
    ((p1 == 0 & shift(p1, type = "lag") == 40) & shift(p2, type = "lag") != 50) |  # Regla 2
    (p1 == 0 & shift(p1, type = "lag") == 50) |  # Regla 3
    ((shift(p1, type = "lag") == 40 & p1 == 40) & (shift(p2, type = "lag") == 50 & p2 == 40)),  # Regla 4
  "P1", "P2"  # Si no se cumple ninguna condición, P2 gana el punto
)]



pbyp_tomi[, point_winner := ifelse(is.na(point_winner), "Nada", point_winner)]
pbyp_tomi[, score := cumsum(ifelse(point_winner == "P1", 1, -1))]



# Crear la columna 'serve_color' con colores claros para la franja y más oscuros para el fondo
pbyp_tomi <- pbyp_tomi %>%
  mutate(
    serve_color = case_when(
      serve_game == "Tomas Martin Etcheverry" ~ "lightblue",
      serve_game == "Cristian Garin" ~ "lightcoral",
      TRUE ~ NA_character_
    ),
    serve_color_dark = case_when(
      serve_game == "Tomas Martin Etcheverry" ~ "deepskyblue3",   # Tono más oscuro de lightblue
      serve_game == "Cristian Garin" ~ "darkred",  # Tono más oscuro de lightcoral
      TRUE ~ NA_character_
    )
  )

# Generar el gráfico con la franja de fondo
ggplot(pbyp_tomi, aes(x = point_number, y = score)) +
  # Franja de fondo con colores según el jugador que saca
  geom_rect(aes(xmin = point_number - 0.5, xmax = point_number + 0.5, ymin = -Inf, ymax = Inf, fill = serve_color_dark), 
            data = pbyp_tomi[!is.na(pbyp_tomi$serve_color_dark),], alpha = 0.3) +
  geom_rect(aes(xmin = point_number - 0.5, xmax = point_number + 0.5, ymin = -Inf, ymax = Inf, fill = serve_color), 
            data = pbyp_tomi[!is.na(pbyp_tomi$serve_color),], alpha = 0.2) +
  # Línea azul principal
  geom_line(color = "blue", size = 1) +
  # Línea vertical verde fluorescente en break points
  geom_vline(data = pbyp_tomi[break_point == 1, ], aes(xintercept = point_number), 
             color = "limegreen", linetype = "dashed", size = 1) +
  # Línea vertical violeta cuando game_score es 40:40
  geom_vline(data = pbyp_tomi[game_score == "40:40", ], aes(xintercept = point_number), 
             color = "purple", linetype = "dashed", size = 1) +
  geom_point(color = "red", size = 2) +
  geom_text(aes(label = match_score), vjust = -1, size = 4, color = "black") +  # Etiquetas de marcador
  labs(title = "Evolución del marcador Etcheverry - Mensik",
       x = "Número de punto",
       y = "Diferencia de puntos acumulada") +
  scale_fill_identity() +  
  scale_x_continuous(breaks = seq(min(pbyp_tomi$point_number), max(pbyp_tomi$point_number), by = 1)) +
  theme_minimal()

