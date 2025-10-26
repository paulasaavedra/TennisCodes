library(dplyr)
library(tidyr)
library(kableExtra)
library(ggplot2)
library(data.table)


dbm <- db [tourney_level != 'CH']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']
dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

#dbm <- dbm [year>2005]
# Clasificar el score en las 3 categorías
dbm[, tipo_score := fifelse(grepl("(?i)walkover", match_status), "Walkover",
                            fifelse(grepl("(?i)finished / retired", match_status), "Finished / Retired",
                                    fifelse(grepl("(?i)^finished$", match_status), "Finished", NA_character_)))]

# Calcular porcentajes por año
resumen <- dbm[!is.na(tipo_score), .N, by = .(year, tipo_score)][
  , porcentaje := 100 * N / sum(N), by = year]

# Transformar a formato ancho para tener columnas separadas
resumen_wide <- dcast(resumen, year ~ tipo_score, value.var = "porcentaje", fill = 0)

resumen_long <- melt(resumen_wide, id.vars = "year",
                      variable.name = "tipo_score", value.name = "porcentaje")
# Datos de ejemplo: resumen_long con etiquetas en español
resumen_long[, tipo_score := factor(tipo_score, 
                                    levels = c("Finished", "Finished / Retired", "Walkover"),
                                    labels = c("Finalizados", "Retiros", "Walkover"))]

# Convertir year a numérico si viene como factor o carácter
resumen_long[, year := as.numeric(as.character(year))]

#resumen_long <- resumen_long [year>2006]
# Gráfico de líneas
ggplot(resumen_long, aes(x = year, y = porcentaje, color = tipo_score)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  scale_x_reverse(breaks = seq(min(resumen_long$year), max(resumen_long$year), by = 1)) +
  labs(title = "Evolución porcentual de resultados de partidos por año",
       x = "Año",
       y = "Porcentaje de partidos",
       color = "Tipo de resultado") +
  theme_minimal()


# opcion 2

ggplot(resumen_long, aes(x = year, y = porcentaje, color = tipo_score)) +
  geom_line(size = 2) +
  geom_point(size = 4, shape = 21, fill = "white") +
  geom_text(aes(label = round(porcentaje, 2)), 
            vjust = -1, 
            size = 3) +
  scale_color_manual(values = c("Finished" = "#1f77b4", 
                                "Finished / Retired" = "#ff7f0e", 
                                "Walkover" = "#2ca02c"),
                     labels = c("Finished" = "Finalizados",
                                "Finished / Retired" = "Retiros",
                                "Walkover" = "Walkover")) +
  scale_y_log10() +
  labs(title = "Evolución porcentual de resultados de partidos por año (escala log)",
       x = "Año",
       y = "Porcentaje (escala log)",
       color = "Tipo de resultado") +
  theme_minimal(base_size = 14)





# opcion 3

ggplot(resumen_long, aes(x = factor(year), y = porcentaje, fill = tipo_score)) +
  geom_bar(stat = "identity") +
  labs(title = "Distribución anual de resultados de partidos",
       x = "Año", y = "Porcentaje", fill = "Tipo de resultado") +
  theme_minimal() +
  coord_flip()  # opcional: voltear para que los años se lean mejor


# opcion 4

ggplot(resumen_long, aes(x = year, y = porcentaje, color = tipo_score)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  ylim(90, 100) +
  labs(title = "Evolución porcentual de resultados de partidos por año (zoom)",
       x = "Año", y = "Porcentaje", color = "Tipo de resultado") +
  theme_minimal()


# Solo ver finalizados
library(ggplot2)

# Mostrar solo finalizados (ya lo tienes)
resumen_long <- resumen_long[tipo_score == "Finalizados"]

ggplot(resumen_long, aes(x = year, y = porcentaje, color = tipo_score)) +
  geom_line(size = 1) +
  geom_point(size = 3, shape = 21, fill = "white") +
  # Mostrar etiquetas solo para el año 2025
  geom_text(data = resumen_long[year == 2025], 
            aes(label = round(porcentaje, 2)), 
            vjust = -2.5, hjust = -0.2,
            size = 5) +
  scale_color_manual(values = c("Finalizados" = "#1f77b4")) +
  scale_y_log10() +
  scale_x_continuous(breaks = resumen_long$year) +
  labs(title = "Evolución porcentual de resultados de partidos por año (escala log)",
       x = "Año",
       y = "Porcentaje (escala log)") +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
    # Líneas de cuadrícula más claras
    panel.grid.major = element_line(color = "gray85", size = 0.3),
    panel.grid.minor = element_line(color = "gray95", size = 0.2)
  )







