library(dplyr)
library(tidyr)
library(kableExtra)
library(data.table)

# --- 0) Filtrado inicial ---
dbm <- db[tourney_level != 'CH']
dbm <- dbm[match_status != 'Walkover']
dbm <- dbm[round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

# Si querés filtrar fechas o torneos, podés activar alguna de estas líneas:
# dbm <- dbm[as.Date(date_match) > as.Date("2024-12-20")]
# dbm <- dbm[month(as.Date(date_match)) %in% c(1, 2, 3)]
# dbm <- dbm[grepl("RIO DE J", tourney_name, ignore.case = TRUE)]

# --- 1) Limpieza de ID de partido ---
dbm[, match_id := sub("_\\d+$", "", match_id)]
dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")
setDT(dbm)
dbm[, id := as.character(id)]

# --- 2) Ordenar por ronda y fecha ---
round_order <- c("R128", "R64", "R32", "R16", "QF", "SF", "F")
dbm[, round_match := factor(round_match, levels = round_order, ordered = TRUE)]
setorder(dbm, year, date_match, tourney_name, round_match)

# --- 3) Función para calcular racha máxima ---
calc_streak <- function(results) {
  max_racha <- 0
  racha_actual <- 0
  for (res in results) {
    if (is.na(res)) next
    if (res == "W") {
      racha_actual <- racha_actual + 1
      max_racha <- max(max_racha, racha_actual)
    } else {
      racha_actual <- 0
    }
  }
  return(max_racha)
}

# --- 4) Construir tabla solo con jugadores argentinos ---
long_arg <- rbind(
  dbm[w_nac == "Argentina", .(player = w_player, opp_nac = l_nac, result = "W", date_match)],
  dbm[l_nac == "Argentina", .(player = l_player, opp_nac = w_nac, result = "L", date_match)]
)

# Eliminar rivales sin nacionalidad
long_arg <- long_arg[!is.na(opp_nac) & opp_nac != ""]

# Ordenar por jugador, nacionalidad rival y fecha
setorder(long_arg, player, opp_nac, date_match)

# --- 5) Calcular racha máxima de cada argentino contra cada país ---
streaks_arg <- long_arg[, .(racha_max = calc_streak(result)), by = .(player, opp_nac)]

# --- 6) Ordenar para ver las mejores rachas ---
streaks_arg <- streaks_arg[order(-racha_max, player)]

# --- 7) Mostrar tabla bonita ---

streaks_arg %>%
  kbl() %>%
  kable_styling(
    full_width = FALSE,
    bootstrap_options = c("striped", "hover"),
    stripe_color = "#efece7",
    font_size = 12
  ) %>%
  # Reducir padding vertical en todas las filas (incluye header)
  row_spec(0, extra_css = "padding-top: 3px; padding-bottom: 3px;") %>%
  row_spec(1:nrow(streaks_arg), extra_css = "padding-top: 3px; padding-bottom: 3px;")

