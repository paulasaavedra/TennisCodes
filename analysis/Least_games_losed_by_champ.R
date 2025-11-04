library(dplyr)
library(tidyr)
library(data.table)
library(stringr)

# 0. Filtrado inicial: eliminar challengers y walkovers
dbm <- db[tourney_level != 'CH']
dbm <- dbm[match_status != 'Walkover']
dbm <- dbm[tourney_level == 'M1000']

# 1. Separar año e ID del match_id
dbm[, match_id := sub("_\\d+$", "", match_id)]
dbm <- dbm %>%
  separate(match_id, into = c("año", "id"), sep = "_")

setDT(dbm)  # Asegurarse que siga siendo data.table
dbm[, id := as.character(id)]

# 2. Crear identificador de torneo unificado
dbm$tourney_id <- paste0(dbm$año, "_", dbm$id)

# 3. Filtrar finales y obtener ganadores
finales <- dbm[round_match == 'F']
finales <- finales[, .(tourney_id, w_player)]

# 4. Obtener partidos ganados por los campeones
partidos <- dbm[, .(tourney_id, w_player, score)]
partidos_ganados <- partidos[finales, on = .(tourney_id, w_player)]

# 5. Calcular juegos perdidos en cada partido
for (i in 1:nrow(partidos_ganados)) {
  sets <- strsplit(partidos_ganados$score[i], " ")[[1]]
  juegos_perdidos <- 0
  
  for (set in sets) {
    resultado <- strsplit(set, "-")[[1]]
    if (length(resultado) < 2) next
    
    resultado[2] <- sub("\\(.*", "", resultado[2])  # Eliminar tiebreaks
    resultado[2] <- ifelse(is.na(resultado[2]) | resultado[2] == "", 0, resultado[2])
    
    juegos_perdidos <- juegos_perdidos + as.numeric(resultado[2])
  }
  
  partidos_ganados$score[i] <- juegos_perdidos
}

# 6. Convertir score a numérico (ahora son juegos perdidos)
partidos_ganados$score <- as.numeric(as.character(partidos_ganados$score))

# 7. Sumar juegos perdidos por torneo y jugador
juegos_totales <- partidos_ganados[, .(juegos_perdidos = sum(score, na.rm = TRUE)),
                                   by = .(tourney_id, w_player)]

# 8. Agregar nombre del torneo
info_final <- unique(dbm[round_match == 'F', .(tourney_id, tourney_name, w_player)])
juegos_totales <- merge(info_final, juegos_totales, by = c("tourney_id", "w_player"))

# 9. Extraer año
juegos_totales$año <- str_sub(juegos_totales$tourney_id, 1, 4)

# 10. Organizar columnas finales
final <- juegos_totales[, .(
  Torneo = tourney_name,
  Año = año,
  Campeón = w_player,
  Juegos_Perdidos = juegos_perdidos
)]

# 11. Ordenar por menos juegos perdidos
final <- final[order(Juegos_Perdidos)]

