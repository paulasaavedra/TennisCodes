library(data.table)
library(lubridate)

# Hacemos el merge con stats
db <- merge(db, db_stats_l_t, by = "match_id", all.x = TRUE)
db <- merge(db, db_stats_w_t, by = "match_id", all.x = TRUE)

# Asegurarse de que la tabla esté en formato data.table
setDT(db)

# Convertir columna de fechas si es necesario
db[, date_match := as.Date(date_match)]

# Fecha de corte
fecha_inicio <- as.Date("2025-01-01")
fecha_hoy <- Sys.Date()

player_stat = 'Francisco Cerundolo'

# Filtrar partidos donde jugó Juan Manuel Cerúndolo y la fecha está dentro del rango
cerundolo_matches <- db[
  (w_player == player_stat | l_player == player_stat) &
    date_match >= fecha_inicio & date_match <= fecha_hoy
]

ganados <- cerundolo_matches[w_player == player_stat]
perdidos <- cerundolo_matches[l_player == player_stat]

cerundolo_matches[, jugador := fifelse(w_player == player_stat, "w", "l")]

# Puntos ganados con 1er saque
cerundolo_matches[, pg_1er_saque := fifelse(jugador == "w", w_t_1st_serve_points_won, l_t_1st_serve_points_won)]
cerundolo_matches[, tot_1er_saque := fifelse(jugador == "w", w_t_1st_serve_points_played, l_t_1st_serve_points_played)]

# Puntos ganados con 2do saque
cerundolo_matches[, pg_2do_saque := fifelse(jugador == "w", w_t_2nd_serve_points_won, l_t_2nd_serve_points_won)]
cerundolo_matches[, tot_2do_saque := fifelse(jugador == "w", w_t_2nd_serve_points_played, l_t_2nd_serve_points_played)]

# Puntos ganados con el servicio (1ro + 2do)
cerundolo_matches[, pg_servicio := fifelse(jugador == "w", w_t_service_points_won, l_t_service_points_won)]
cerundolo_matches[, tot_servicio := fifelse(jugador == "w", w_t_service_points_played, l_t_service_points_played)]

# Puntos ganados con devolución de 1ro
cerundolo_matches[, pg_primera_dev := fifelse(jugador == "w", w_t_1st_return_points_won, l_t_1st_return_points_won)]
cerundolo_matches[, tot_primera_dev := fifelse(jugador == "w", w_t_1st_return_points_played, l_t_1st_return_points_played)]

# Puntos ganados con devolución de 2do
cerundolo_matches[, pg_segunda_dev := fifelse(jugador == "w", w_t_2nd_return_points_won, l_t_2nd_return_points_won)]
cerundolo_matches[, tot_segunda_dev := fifelse(jugador == "w", w_t_2nd_return_points_played, l_t_2nd_return_points_played)]

# Puntos ganados en devolución total
cerundolo_matches[, pg_devolucion := fifelse(jugador == "w", w_t_return_points_won, l_t_return_points_won)]
cerundolo_matches[, tot_devolucion := fifelse(jugador == "w", w_t_return_points_played, l_t_return_points_played)]


cerundolo_matches[, rate_pg_primer_saque := pg_1er_saque / (tot_1er_saque)]
cerundolo_matches[, rate_pg_segundo_saque := pg_2do_saque / (tot_2do_saque)]
cerundolo_matches[, rate_pg_servicio := pg_servicio / (tot_servicio)]

cerundolo_matches[, rate_pg_primera_dev := pg_primera_dev / (tot_primera_dev)]
cerundolo_matches[, rate_pg_segunda_dev := pg_segunda_dev / (tot_segunda_dev)]
cerundolo_matches[, rate_pg_devolucion := pg_devolucion / (tot_devolucion)]



# Crear columna de mes en formato año-mes
cerundolo_matches[, mes := format(date_match, "%Y-%m")]
# Crear la nueva columna concatenando el mes y el nombre del torneo
cerundolo_matches[, date_tourney := paste(format(date_match, "%m"), tourney_name, sep = "_")]
cerundolo_matches <- cerundolo_matches[order(date_match)]

orden_torneos <- unique(cerundolo_matches$tourney_name)

# Promedios mensuales de rates de saque
saque_mensual <- cerundolo_matches[, .(
  rate_pg_primer_saque = mean(rate_pg_primer_saque, na.rm = TRUE),
  rate_pg_segundo_saque = mean(rate_pg_segundo_saque, na.rm = TRUE),
  rate_pg_servicio = mean(rate_pg_servicio, na.rm = TRUE)
), by = tourney_name] 

saque_mensual$tourney_name <- factor(saque_mensual$tourney_name, levels = orden_torneos)
saque_mensual <- saque_mensual[order(tourney_name)]



# Promedios mensuales de rates de devolución
devolucion_mensual <- cerundolo_matches[, .(
  rate_pg_primera_dev = mean(rate_pg_primera_dev, na.rm = TRUE),
  rate_pg_segunda_dev = mean(rate_pg_segunda_dev, na.rm = TRUE),
  rate_pg_devolucion = mean(rate_pg_devolucion, na.rm = TRUE)
), by = tourney_name]

devolucion_mensual$tourney_name <- factor(devolucion_mensual$tourney_name, levels = orden_torneos)
devolucion_mensual <- devolucion_mensual[order(tourney_name)]


############### GRAFICOS en funcion de FECHAS ################


library(ggplot2)
library(reshape2)

# Reestructurar datos a formato largo para el gráfico
saque_long <- melt(saque_mensual, id.vars = "tourney_name", variable.name = "tipo_rate", value.name = "valor")
devolucion_long <- melt(devolucion_mensual, id.vars = "tourney_name", variable.name = "tipo_rate", value.name = "valor")

# Gráfico de saque
ggplot(saque_long, aes(x = tourney_name, y = valor, color = tipo_rate, group = tipo_rate)) +
  geom_line(size = 1) +
  geom_point() +
  labs(title = "Rates de Saque - Juan Manuel Cerúndolo", x = "tourney_name", y = "Valor del rate") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Gráfico de devolución
ggplot(devolucion_long, aes(x = tourney_name, y = valor, color = tipo_rate, group = tipo_rate)) +
  geom_line(size = 1) +
  geom_point() +
  labs(title = "Rates de Devolución - Juan Manuel Cerúndolo", x = "Mes", y = "Valor del rate") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


###############   SAQUE Y DEVOLUCION    ######################

# Crear tabla con ambas métricas combinadas
resumen_saque_devol <- cerundolo_matches[, .(
  rate_pg_servicio = mean(rate_pg_servicio, na.rm = TRUE),
  rate_pg_devolucion = mean(rate_pg_devolucion, na.rm = TRUE)
), by = tourney_name]

# Mantener orden cronológico
resumen_saque_devol$tourney_name <- factor(resumen_saque_devol$tourney_name, levels = orden_torneos)
resumen_saque_devol <- resumen_saque_devol[order(tourney_name)]

# Convertir a formato largo para graficar
resumen_long <- melt(resumen_saque_devol, id.vars = "tourney_name", variable.name = "tipo_rate", value.name = "valor")

setDT(resumen_long)

# Renombrar tipo_rate
resumen_long[, tipo_rate := fcase(
  tipo_rate == "rate_pg_servicio", "Rate Servicio",
  tipo_rate == "rate_pg_devolucion", "Rate Devolución"
)]


# Gráfico con etiquetas
ggplot(resumen_long, aes(x = tourney_name, y = valor, color = tipo_rate, group = tipo_rate)) +
  geom_line(size = 1.5) +
  geom_point(size = 3.5) +
  geom_text(aes(label = round(valor, 2)), 
            vjust = -1,       # Mover el texto un poco más arriba
            hjust = 0.5,      # Centrar el texto respecto al punto
            nudge_y = 0.02,   # Ajuste vertical para evitar superposiciones
            size = 4) +       # Aumentar el tamaño de los labels
  labs(title = "Rate de Servicio vs Devolución - Francisco Cerúndolo", 
       x = "", y = "") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 0, hjust = 0.5, size = 10),
    legend.text = element_text(size = 10),
    plot.title = element_text(hjust = 0.5, size = 14),
    legend.position = c(0.93, 0.75)
  ) +
  guides(color = guide_legend(title = NULL))

