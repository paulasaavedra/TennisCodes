library(dplyr)
library(tidyr)
library(kableExtra)
library(data.table)


library(data.table)
library(lubridate)

### ------------------------------
### 1) Preparar datos
### ------------------------------

# Filtrar solo apariciones dentro del Top 100
rank_top100 <- rank[rank_position <= 100]

# Debut: primera aparición de cada jugador en el Top 100
debut_top100 <- rank_top100[
  order(player_id, date_rank, country),
  .SD[1],
  by = player_id
]

# Resultados organizados
debut_top100_result <- debut_top100[, .(
  player_id,
  player,
  country,
  debut_date = date_rank,
  debut_age  = age,
  debut_rank = rank_position
)]

# Agregar año de debut
debut_top100_result[, debut_year := year(debut_date)]

### ------------------------------
### 2) Promedio anual de edad de debut
### ------------------------------

avg_age_by_year <- debut_top100_result[
  , .(
    mean_age   = mean(debut_age, na.rm = TRUE),
    median_age = median(debut_age, na.rm = TRUE),
    n_players  = .N
  ),
  by = debut_year
][order(debut_year)]


### ------------------------------
### 3) Tendencia (regresión)
### ------------------------------

trend_model <- lm(mean_age ~ debut_year, data = avg_age_by_year)
trend_summary <- summary(trend_model)


### ------------------------------
### 4) Estadísticas globales de edad de debut
### ------------------------------

debut_age_stats <- debut_top100_result[
  , .(
    mean_age   = mean(debut_age),
    median_age = median(debut_age),
    sd_age     = sd(debut_age),
    min_age    = min(debut_age),
    max_age    = max(debut_age),
    players    = .N
  )
]


### ------------------------------
### 5) Estadísticas del ranking al debut
### ------------------------------

debut_rank_stats <- debut_top100_result[
  , .(
    mean_rank   = mean(debut_rank),
    median_rank = median(debut_rank),
    sd_rank     = sd(debut_rank),
    min_rank    = min(debut_rank),
    max_rank    = max(debut_rank)
  )
]



debut_by_country <- debut_top100_result[
  , .N,
  by = c('debut_year','country')
][order(-N)]



library(ggplot2)
library(data.table)

# Usamos el objeto avg_age_by_year generado antes
# avg_age_by_year tiene columnas: debut_year, mean_age, median_age, n_players

### ============================
### 1) Gráfico: Promedio anual de edad de debut
### ============================

ggplot(avg_age_by_year, aes(x = debut_year, y = mean_age)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "Promedio anual de edad de debut en el Top 100",
    x = "Año de debut",
    y = "Edad promedio al debut"
  ) +
  theme_minimal()


### ============================
### 2) Gráfico: Cantidad de debutantes por año
### ============================

ggplot(avg_age_by_year, aes(x = debut_year, y = n_players)) +
  geom_col() +
  labs(
    title = "Cantidad de jugadores que debutaron en el Top 100 por año",
    x = "Año de debut",
    y = "Cantidad de jugadores"
  ) +
  theme_minimal()





library(ggplot2)
library(data.table)
library(showtext)

# --- Activar fuente Poppins desde Google Fonts ---
font_add_google("Poppins", "poppins")
showtext_auto()

# Filtrar desde el año 2000
plot_data <- avg_age_by_year[debut_year >= 2016]

ggplot(plot_data, aes(x = debut_year)) +
  
  # --- Barras: cantidad de jugadores ---
  geom_col(aes(y = n_players),
           fill = "#70a1d4",
           alpha = 0.9) +
  
  # Etiquetas de los valores en las barras
  geom_text(aes(y = n_players, label = n_players),
            vjust = -0.3, size = 3, family = "poppins") +
  
  # --- Línea: edad promedio ---
  geom_line(aes(y = mean_age * 5),
            size = 1.1,
            color = "#004c72") +
  
  geom_point(aes(y = mean_age * 5),
             size = 2.5,
             color = "#004c72") +
  
  # Etiquetas sobre los puntos
  geom_text(aes(y = mean_age * 5, label = round(mean_age, 1)),
            vjust = -0.7,
            color = "#004c72",
            size = 3,
            family = "poppins") +
  
  # --- Ejes ---
  scale_x_continuous(
    breaks = plot_data$debut_year,
    expand = expansion(mult = c(0.01, 0.05))
  ) +
  
  scale_y_continuous(
    name = " ",
    sec.axis = sec_axis(~./5, name = " ")
  ) +
  
  # --- Títulos ---
  labs(
    title = "Debut en el Top 100 (desde 2016)",
    subtitle = "Cantidad anual de debutantes (Barras) + Edad promedio al debut (Línea)",
    x = " ",
    y = "Cantidad"
  ) +
  
  theme_minimal(base_family = "poppins") +   # <<< Fijar Poppins en TODO
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )

