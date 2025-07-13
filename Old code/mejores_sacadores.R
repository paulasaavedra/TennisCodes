# Primero me quedo con los partidos del torneo que quiero
dbm <- db [tourney_name == 'Australian Open']

dbm <- db [as.Date(date_match, format = "%Y-%m-%d") > as.Date("2024-12-20")]

# Me quedo con las columnas que me interesa analizar
dbm <- dbm[, .(match_id, w_player, w_nac, l_player, l_nac, score)]

# Me traigo las estadisticas totales del ganador
dbm <- merge(
  dbm, 
  db_stats_w_t[, .(match_id, w_t_aces, w_t_double_faults, w_t_average_1st_serve_speed, w_t_average_2nd_serve_speed,
                   w_t_1st_serve_percentage, w_t_1st_serve_points_won_percentage, w_t_2nd_serve_points_won_percentage,
                   w_t_service_points_won_percentage, w_t_service_games_won_percentage)],  
  by = "match_id", 
  all.x = TRUE
)

# Me traigo las estadisticas totales del perdedor
dbm <- merge(
  dbm, 
  db_stats_l_t[, .(match_id, l_t_aces, l_t_double_faults, l_t_average_1st_serve_speed, l_t_average_2nd_serve_speed,
                   l_t_1st_serve_percentage, l_t_1st_serve_points_won_percentage, l_t_2nd_serve_points_won_percentage,
                   l_t_service_points_won_percentage, l_t_service_games_won_percentage)],  
  by = "match_id", 
  all.x = TRUE
)



# Crear un nuevo data.table con las columnas de los ganadores
winners <- dbm[, .(
  player = w_player,
  nac = w_nac,
  aces = w_t_aces,
  df = w_t_double_faults,
  first_serve_percentage = w_t_1st_serve_percentage,
  first_serve_points_won_percentage = w_t_1st_serve_points_won_percentage,
  second_serve_points_won_percentage = w_t_2nd_serve_points_won_percentage,
  serve_points_won_percentage = w_t_service_points_won_percentage,
  service_games_won_percentage = w_t_service_games_won_percentage
)]

# Crear un nuevo data.table con las columnas de los perdedores
losers <- dbm[, .(
  player = l_player,
  nac = l_nac,
  aces = l_t_aces,
  df = l_t_double_faults,
  first_serve_percentage = l_t_1st_serve_percentage,
  first_serve_points_won_percentage = l_t_1st_serve_points_won_percentage,
  second_serve_points_won_percentage = l_t_2nd_serve_points_won_percentage,
  serve_points_won_percentage = l_t_service_points_won_percentage,
  service_games_won_percentage = l_t_service_games_won_percentage
)]

# Combinar ambas tablas, una debajo de la otra
combined <- rbind(winners, losers)

winners_filtered <- winners[, if (.N >= 5) .SD, by = player]

# Calcular promedios por jugador
player_avg <- winners_filtered[, .(
  avg_aces = sum(aces, na.rm = TRUE),
  avg_df = sum(df, na.rm = TRUE),
  avg_first_serve_percentage = mean(first_serve_percentage, na.rm = TRUE),
  avg_first_serve_points_won_percentage = mean(first_serve_points_won_percentage, na.rm = TRUE),
  avg_second_serve_points_won_percentage = mean(second_serve_points_won_percentage, na.rm = TRUE),
  avg_serve_points_won_percentage = mean(serve_points_won_percentage, na.rm = TRUE),
  avg_service_games_won_percentage = mean(service_games_won_percentage, na.rm = TRUE)
), by = player]


player_avg[, (names(player_avg)) := lapply(.SD, function(x) if (is.numeric(x)) round(x) else x)]

fwrite(player_avg, file = "C:/Users/Paula/Desktop/datita.csv", sep = ",", dec = ".", row.names = FALSE)



library(pheatmap)

# Preparar datos
heatmap_data <- as.matrix(player_avg[, -1])  # Excluir la columna PLAYER

# Agregar nombres de jugadores como fila
rownames(heatmap_data) <- player_avg$player

# Crear el heatmap
pheatmap(
  heatmap_data,
  scale = "column",  # Escala cada columna
  cluster_rows = TRUE,  # Agrupar jugadores similares
  cluster_cols = FALSE,  # Mantener las métricas fijas
  color = colorRampPalette(c("white", "blue"))(50),
  main = "Desempeño promedio por jugador"
)


library(ggplot2)

# Seleccionar la métrica a analizar
metric <- "avg_serve_points_won_percentage"

# Crear gráfico de barras
ggplot(player_avg, aes(x = reorder(player, get(metric)), y = get(metric))) +
  geom_bar(stat = "identity", fill = "skyblue") +
  coord_flip() +
  labs(
    title = "Comparación de jugadores",
    x = "Jugador",
    y = "Porcentaje de puntos ganados en servicio"
  ) +
  theme_minimal()



library(ggplot2)

# Seleccionar la métrica a analizar
metric <- "avg_serve_points_won_percentage"

# Crear gráfico de barras estilizado
ggplot(player_avg, aes(x = reorder(player, get(metric)), y = get(metric))) +
  geom_bar(stat = "identity", fill = "#98b8d9", color = "#ffffff", size = 1) +  # Barra con color y borde
  geom_text(aes(label = round(get(metric), 1)), hjust = 1.2, color = "#ffffff", fontface = "bold") +  # Etiquetas en las barras
  coord_flip() +  # Coordenadas para que las barras sean horizontales
  labs(
    title =  "Porcentaje de puntos totales ganados con el servicio",
    x = " ",
    y = " "
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", color = "#004c72"),
    axis.title.x = element_text(size = 8, face = "bold", color = "#004c72"),
    axis.title.y = element_text(size = 10, face = "bold", color = "#004c72"),
    axis.text = element_text(size = 10, color = "#004c72"),
    #panel.grid.major = element_blank(),  # Eliminar la cuadrícula mayor
    #panel.grid.minor = element_blank(),  # Eliminar la cuadrícula menor
    panel.background = element_rect(fill = "#ffffff", color = NA)
  ) +
  theme(legend.position = "none")



library(ggplot2)

# Seleccionar la métrica a analizar
metric <- "avg_service_games_won_percentage"

# Crear gráfico de barras estilizado
ggplot(player_avg, aes(x = reorder(player, get(metric)), y = get(metric))) +
  geom_bar(stat = "identity", fill = "#98b8d9", color = "#ffffff", size = 1) +  # Barra con color y borde
  geom_text(aes(label = round(get(metric), 1)), hjust = 1.2, color = "#ffffff", fontface = "bold") +  # Etiquetas en las barras
  coord_flip() +  # Coordenadas para que las barras sean horizontales
  labs(
    title =  "Porcentaje de games ganados con el servicio",
    x = " ",
    y = " "
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", color = "#004c72"),
    axis.title.x = element_text(size = 8, face = "bold", color = "#004c72"),
    axis.title.y = element_text(size = 10, face = "bold", color = "#004c72"),
    axis.text = element_text(size = 10, color = "#004c72"),
    #panel.grid.major = element_blank(),  # Eliminar la cuadrícula mayor
    #panel.grid.minor = element_blank(),  # Eliminar la cuadrícula menor
    panel.background = element_rect(fill = "#ffffff", color = NA)
  ) +
  theme(legend.position = "none")




