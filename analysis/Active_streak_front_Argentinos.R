library(dplyr)
library(tidyr)
library(kableExtra)


dbm <- db [tourney_level != 'CH']
dbm <- dbm [match_status != 'Walkover']
#dbm <- dbm [surface =='Clay']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

#Filtra una fecha
#dbm <- dbm [as.Date(date_match, format = "%Y-%m-%d") > as.Date("2024-12-20")]

# Filtra enero o febrero
#dbm <- dbm[month(as.Date(date_match, format = "%Y-%m-%d")) %in% c(1, 2, 3)]

#dbm <- dbm[grepl("RIO DE J", tourney_name, ignore.case = TRUE)]

dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)  # Convierte dbm en data.table si dejó de serlo
dbm[, id := as.character(id)]



# --- 1) Ordenar el data.table según tu criterio ---
round_order <- c("R128", "R64", "R32", "R16", "QF", "SF", "F")
dbm[, round_match := factor(round_match, levels = round_order, ordered = TRUE)]
setorder(dbm, year, date_match, tourney_name, round_match)

# --- 2) Función para calcular la racha más larga ---
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

# --- 3) Generar tabla "larga" con un registro por jugador y partido ---
#    Incluye tanto cuando fue ganador como cuando fue perdedor
long <- rbind(
  dbm[, .(player = w_player, opp_nac = l_nac, result = "W", date_match)],
  dbm[, .(player = l_player, opp_nac = w_nac, result = "L", date_match)]
)

# --- 4) Eliminar partidos sin nacionalidad rival ---
long <- long[!is.na(opp_nac) & opp_nac != ""]

# --- 5) Ordenar por jugador, nacionalidad rival y fecha ---
setorder(long, player, opp_nac, date_match)

# --- 6) Calcular racha más larga por jugador y nacionalidad rival ---
streaks <- long[, .(racha_max = calc_streak(result)), by = .(player, opp_nac)]