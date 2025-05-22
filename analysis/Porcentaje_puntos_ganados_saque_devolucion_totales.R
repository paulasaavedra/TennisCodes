library(dplyr)
library(tidyr)
library(data.table)

# Hacemos el merge con stats
dbm <- merge(db, db_stats_l_t, by = "match_id", all.x = TRUE)
dbm <- merge(dbm, db_stats_w_t, by = "match_id", all.x = TRUE)

#dbm <- db [tourney_level != 'CH']
dbm <- dbm [match_status != 'Walkover']

dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

#Filtra una fecha
dbm <- dbm [as.Date(date_match, format = "%Y-%m-%d") > as.Date("2024-12-20")]

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

dbm <- dbm [id == '1536' & round_match == 'R64']

# Crear columnas proporcionales por partido
dbm[, `:=`(
  w_pct_serve_points_won = w_t_service_points_won / w_t_service_points_played,
  w_pct_return_points_won = w_t_return_points_won / w_t_return_points_played,
  w_pct_total_points_won = w_t_total_points_won / w_t_total_points_played
)]

# Resumen por jugador (solo partidos ganados)
resumen <- dbm[, .(
  partidos_ganados = .N,
  prom_serve_points_won = mean(w_t_service_points_won / w_t_service_points_played, na.rm = TRUE),
  prom_return_points_won = mean(w_t_return_points_won / w_t_return_points_played, na.rm = TRUE),
  prom_total_points_won = mean(w_t_total_points_won / w_t_total_points_played, na.rm = TRUE)
), by = w_player][order(-prom_serve_points_won)]


library(ggplot2)
library(data.table)
library(scales)

# Filtrar top 5 jugadores por proporción total
top5 <- resumen[order(-prom_total_points_won)][1:5]

# Formato largo para ggplot
top5_melt <- melt(
  top5,
  id.vars = "w_player",
  measure.vars = c("prom_serve_points_won", "prom_return_points_won", "prom_total_points_won"),
  variable.name = "Tipo",
  value.name = "Proporcion"
)

# Renombrar para claridad
top5_melt[, Tipo := factor(Tipo,
                           levels = c("prom_serve_points_won", "prom_return_points_won", "prom_total_points_won"),
                           labels = c("Puntos ganados con el saque", 
                                      "Puntos ganados con la devolución", 
                                      "Puntos ganados en total"))]

# Gráfico
ggplot(top5_melt, aes(x = reorder(w_player, -Proporcion), y = Proporcion, fill = Tipo)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), width = 0.7) +
  geom_text(aes(label = percent(Proporcion, accuracy = 1)),
            position = position_dodge(width = 0.8), vjust = -0.3, size = 3.5) +
  scale_y_continuous(labels = percent_format(accuracy = 1), limits = c(0, 1)) +
  scale_fill_manual(values = c(
    "Puntos ganados con el saque" = "#1f77b4",   # azul
    "Puntos ganados con la devolución" = "#d62728",  # rojo
    "Puntos ganados en total" = "#2ca02c"        # verde
  )) +
  labs(
    title = "Rendimiento en puntos de los 5 mejores ganadores",
    subtitle = "Proporciones de puntos ganados con el saque, devolución y total",
    x = "Jugador",
    y = "Proporción de puntos ganados",
    fill = "Tipo de punto"
  ) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "bottom")




library(ggplot2)
library(data.table)
library(scales)

# Top 5 por rendimiento total
top5 <- resumen[order(-prom_total_points_won)][1:5]

# Pasar a formato largo
top5_melt <- melt(
  top5,
  id.vars = "w_player",
  measure.vars = c("prom_serve_points_won", "prom_return_points_won", "prom_total_points_won"),
  variable.name = "Tipo",
  value.name = "Proporcion"
)

# Nombres más claros
top5_melt[, Tipo := factor(Tipo,
                           levels = c("prom_serve_points_won", "prom_return_points_won", "prom_total_points_won"),
                           labels = c("Saque", "Devolución", "Total"))]

# Gráfico tipo lollipop
ggplot(top5_melt, aes(x = Proporcion, y = reorder(w_player, Proporcion), color = Tipo)) +
  geom_segment(aes(x = 0, xend = Proporcion, yend = w_player), size = 1.2) +
  geom_point(size = 4) +
  geom_text(aes(label = percent(Proporcion, accuracy = 1)), hjust = -0.2, size = 3.5) +
  scale_x_continuous(labels = percent_format(accuracy = 1), limits = c(0, 1)) +
  scale_color_manual(values = c("Saque" = "#1f77b4", "Devolución" = "#d62728", "Total" = "#2ca02c")) +
  facet_wrap(~Tipo, ncol = 1) +
  labs(
    title = "Top 5 ganadores: proporción de puntos ganados",
    subtitle = "Comparación por tipo de punto (saque, devolución, total)",
    x = "Proporción", y = "Jugador"
  ) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "none")
