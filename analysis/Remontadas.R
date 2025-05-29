library(dplyr)
library(tidyr)
library(kableExtra)
library(stringr)
library(dplyr)
library(ggplot2)

dbm <- db [tourney_level!='CH']
dbm <- dbm [match_status!= 'Walkover']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']
dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)

dbm[, match_score_clean := gsub("\\(\\d+\\)", "", score)]


# A tres sets 
dbm <- dbm [year ==2025]

dbm <- dbm[best==3]


dbm <- dbm %>%
  mutate(
    sets = strsplit(match_score_clean, " "),
    Dado_vuelta = sapply(sets, function(set) {
      # Verificamos que haya al menos 3 sets
      if (length(set) >= 3) {
        # Intentamos extraer los sets de forma segura
        s1 <- suppressWarnings(as.numeric(unlist(strsplit(set[1], "-"))))
        s2 <- suppressWarnings(as.numeric(unlist(strsplit(set[2], "-"))))
        s3 <- suppressWarnings(as.numeric(unlist(strsplit(set[3], "-"))))
        
        # Verificamos que cada set tenga dos números válidos
        if (
          length(s1) == 2 && length(s2) == 2 && length(s3) == 2 &&
          all(!is.na(c(s1, s2, s3)))
        ) {
          if (s1[1] < s1[2] && s2[1] > s2[2] && s3[1] > s3[2]) {
            return("SI")
          }
        }
      }
      return("NO")
    })
  )

remontados <- dbm [Dado_vuelta=='SI']
remontados <- remontados[,.N,by=l_player]




# A cinco sets 
dbm <- dbm[best==5]

library(dplyr)
library(stringr)


dbm <- dbm %>%
  mutate(
    sets = strsplit(match_score_clean, " "),
    Dado_vuelta = sapply(sets, function(set) {
      # Verificamos que haya al menos 5 sets
      if (length(set) >= 5) {
        # Intentamos extraer los sets de forma segura
        s1 <- suppressWarnings(as.numeric(unlist(strsplit(set[1], "-"))))
        s2 <- suppressWarnings(as.numeric(unlist(strsplit(set[2], "-"))))
        s3 <- suppressWarnings(as.numeric(unlist(strsplit(set[3], "-"))))
        s4 <- suppressWarnings(as.numeric(unlist(strsplit(set[5], "-"))))
        s5 <- suppressWarnings(as.numeric(unlist(strsplit(set[5], "-"))))
        
        # Verificamos que cada set tenga dos números válidos
        if (
          length(s1) == 2 && length(s2) == 2 && length(s3) == 2 && length(s4) == 2 && length(s5) == 2 &&
          all(!is.na(c(s1, s2, s3, s4, s5)))
        ) {
          if (s1[1] < s1[2] && s2[1] < s2[2] && s3[1] > s3[2] && s4[1] > s4[2] && s5[1] > s5[2]) {
            return("SI")
          }
        }
      }
      return("NO")
    })
  )

remontados <- dbm [Dado_vuelta=='SI']
remontados <- remontados[,.N,by=l_player]

remontadas_por_torneo <- remontados[,.N,by=c('year','tourney_name')]


# Paso 1: Filtrar y quedarnos solo con Roland Garros en los últimos 10 años
roland_data <- remontadas_por_torneo %>%
  filter(tourney_name == "Roland Garros", year >= 2003)

# Paso 2: Agregar 2025 manualmente
roland_data <- bind_rows(
  roland_data,
  data.frame(year = '2025', tourney_name = "Roland Garros", N = 7)
)
# Paso 3: Ordenar por año por si no está ordenado
roland_data <- roland_data %>%
  arrange(year)

# Paso 4: Graficar con etiquetas de número
ggplot(roland_data, aes(x = factor(year), y = N)) +
  geom_bar(stat = "identity", fill = "#0072B2") +
  geom_text(aes(label = N), vjust = -0.5, color = "black", size = 4) +
  labs(
    title = "Remontadas en Roland Garros (últimos 10 años)",
    x = "Año",
    y = "Cantidad de remontadas"
  ) +
  theme_minimal()
