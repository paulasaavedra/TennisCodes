library(dplyr)
library(data.table)
library(tidyr)
library(kableExtra)

# Filtro solo partidos de jugadores argentinos (ganen o pierdan)
long <- rbind(
  dbm[, .(player = w_player, player_nac = w_nac, opp = l_player, result = "W", date_match)],
  dbm[, .(player = l_player, player_nac = l_nac, opp = w_player, result = "L", date_match)]
)

# Me quedo solo con jugadores argentinos
long <- long[player_nac == "Argentina"]

# Ordeno por jugador, rival y fecha
setorder(long, player, opp, date_match)

# Función para calcular racha más larga
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

# Calculo la racha máxima por jugador y rival
streaks_vs_rival <- long[, .(racha_max = calc_streak(result)), by = .(player, opp)]

# Opcional: solo mostrar rachas > 1
streaks_vs_rival <- streaks_vs_rival[racha_max > 1]

# Ordeno de mayor a menor racha
streaks_vs_rival <- streaks_vs_rival[order(-racha_max)]




