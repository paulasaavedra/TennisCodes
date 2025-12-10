library(dplyr)
library(tidyr)


dbm <- db [tourney_level == 'GS']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]

# ================================
# JUGADORES POR PAIS POR TORNEO 
# ================================

country_by_round <- dbm %>%
  select(year, id, tourney_name, round_match, w_nac, l_nac) %>%
  pivot_longer(
    cols = c(w_nac, l_nac),
    names_to = "rol",
    values_to = "pais"
  ) %>%
  group_by(year, id, tourney_name, round_match, pais) %>%
  summarise(total = n(), .groups = "drop")
