library(data.table)
library(DT)

# Asegurarse de que dbm sea un data.table
setDT(dbm)
dbm <-db
# Diccionario: países → emojis de banderas
# (podés agregar más si querés)
banderas <- c(
  "New Zealand" = "🇳🇿",
  "Germany" = "🇩🇪",
  "Switzerland" = "🇨🇭",
  "Hong Kong" = "🇭🇰",
  "Australia" = "🇦🇺",
  "Morocco" = "🇲🇦",
  "France" = "🇫🇷",
  "United States" = "🇺🇸",
  "Netherlands" = "🇳🇱",
  "Monaco" = "🇲🇨",
  "Italy" = "🇮🇹",
  "Spain" = "🇪🇸",
  "Qatar" = "🇶🇦",
  "United Arab Emirates" = "🇦🇪",
  "Argentina" = "🇦🇷",
  "Mexico" = "🇲🇽",
  "Romania" = "🇷🇴",
  "Brazil" = "🇧🇷",
  "Chile" = "🇨🇱"
)


# Agregamos una columna con la bandera
dbm[, bandera := banderas[w_nac]]

top_jugadores <- function(variable, top = 10) {
  dbm[, .(total = sum(get(variable), na.rm = TRUE), bandera = unique(banderas[w_nac])), by = w_player][
    order(-total)
  ][1:top]
}

datatable(top_jugadores("w_t_aces"), escape = FALSE)
datatable(top_jugadores("w_t_winners"), escape = FALSE)