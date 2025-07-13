# Supongamos que tu datatable se llama "db"
# Crear una nueva columna con las combinaciones de nombres ordenadas alfabéticamente

dbm <- db [date_match > '2022-01-01']

dbm <- dbm [w_nac == 'ARG' & l_nac == 'ARG']

dbm$player_combination <- apply(dbm[, c("w_player", "l_player")], 1, function(x) {
  paste(sort(x), collapse = " vs ")
})

# Contar la frecuencia de cada combinación
combinacion_frecuencia <- table(dbm$player_combination)


combinacion_frecuencia <- data.table(combinacion = names(combinacion_frecuencia), frecuencia = combinacion_frecuencia)
