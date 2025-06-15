library(dplyr)
library(tidyr)
library(data.table)
library(gridExtra)
library(grid)
library(gtable)
library(png)

# --- Parte 1: Preparar datos y calcular métricas ---

# Filtrar dataset base
dbm <- db[date_match > "2024-12-20" & tourney_name == 'Santa Fe']

# Merge con stats
dbm <- merge(dbm, db_stats_l_t, by = "match_id", all.x = TRUE)
dbm <- merge(dbm, db_stats_w_t, by = "match_id", all.x = TRUE)

# Función para extraer y renombrar columnas del ganador o perdedor
extract_stats <- function(dbm, prefix, result_col = NULL) {
  cols <- grep(paste0("^", prefix), names(dbm), value = TRUE)
  dt <- dbm[, ..cols]
  setnames(dt, gsub(paste0("^", prefix), "", names(dt)))
  dt[, player := dbm[[paste0(substr(prefix, 1, 1), "_player")]]]
  dt[, nac := dbm[[paste0(substr(prefix, 1, 1), "_nac")]]]
  dt[, result := if (!is.null(result_col)) dbm[[result_col]] else NA]
  return(dt)
}

# Ganadores y perdedores en formato largo
w_stats <- extract_stats(dbm, "w_t_", "winner")
l_stats <- extract_stats(dbm, "l_t_", "winner")
long_stats <- rbind(w_stats, l_stats, fill = TRUE)

# Convertir columnas a numérico
num_cols <- setdiff(names(long_stats), c("player", "nac", "result"))
long_stats[, (num_cols) := lapply(.SD, as.numeric), .SDcols = num_cols]

# Calcular nuevas métricas de porcentaje
long_stats[, `:=`(
  pct_1st_serve_won = 100 * `1st_serve_points_won` / `1st_serve_points_played`,
  pct_2nd_serve_won = 100 * `2nd_serve_points_won` / `2nd_serve_points_played`,
  pct_aces_df = 100 * aces / (aces + double_faults),
  pct_winners_ue = 100 * winners / (winners + unforced_errors),
  pct_bp_saved = break_points_saved_percentage,
  pct_bp_converted = break_points_converted_percentage,
  pct_return_1st = `1st_return_points_won_percentage`,
  pct_return_2nd = `2nd_return_points_won_percentage`,
  pct_total_points = total_points_won_percentage,
  pct_total_points_serve = 100 * service_points_won / service_points_played,
  pct_total_points_return = 100 * return_points_won / return_points_played,
  pct_net_points = net_points_won_percentage
)]

# Identificar jugadores invictos y filtrar
ganadores <- unique(dbm$w_player)
perdedores <- unique(dbm$l_player)
invictos <- setdiff(ganadores, perdedores)
long_stats <- long_stats[player %in% invictos]

# Lista completa de métricas a usar
metricas <- c(
  "pct_1st_serve_won", "pct_2nd_serve_won",
  "pct_bp_saved", "pct_bp_converted",
  "pct_return_1st", "pct_return_2nd",
  "pct_total_points_serve", "pct_total_points_return",
  "pct_total_points", "pct_aces_df", "pct_winners_ue",
  "pct_net_points",
  "aces_totales", "dobles_faltas_totales", "tiempo_total_min"
)

# --- Cálculo combinado: métricas ponderadas, promedios y totales ---

# 1) Métricas ponderadas
acumulados <- long_stats[, .(
  nac = first(nac),
  total_1st_serve_won = sum(`1st_serve_points_won`, na.rm = TRUE),
  total_1st_serve_played = sum(`1st_serve_points_played`, na.rm = TRUE),
  total_2nd_serve_won = sum(`2nd_serve_points_won`, na.rm = TRUE),
  total_2nd_serve_played = sum(`2nd_serve_points_played`, na.rm = TRUE)
), by = player]
acumulados[, `:=`(
  pct_1st_serve_won = 100 * total_1st_serve_won / total_1st_serve_played,
  pct_2nd_serve_won = 100 * total_2nd_serve_won / total_2nd_serve_played
)]

# 2) Promedios simples de otras métricas
metricas_promedio <- c(
  "pct_bp_saved", "pct_bp_converted",
  "pct_return_1st", "pct_return_2nd",
  "pct_total_points_serve", "pct_total_points_return",
  "pct_total_points", "pct_aces_df",
  "pct_winners_ue", "pct_net_points"
)
otras_metricas <- long_stats[, lapply(.SD, mean, na.rm = TRUE), by = player, .SDcols = metricas_promedio]

# 3) Totales nuevos: aces, dobles faltas, tiempo
# Extraer tiempo total desde dbm y asociarlo a jugadores
tiempos <- rbind(
  dbm[, .(player = w_player, time_total)],
  dbm[, .(player = l_player, time_total)]
)

# Filtrar jugadores invictos
tiempos <- tiempos[player %in% invictos]

# Sumar minutos por jugador
tiempos_por_jugador <- tiempos[, .(tiempo_total_min = sum(time_total, na.rm = TRUE)), by = player]

# Sumar aces y dobles faltas desde long_stats
extras <- long_stats[, .(
  aces_totales = sum(aces, na.rm = TRUE),
  dobles_faltas_totales = sum(double_faults, na.rm = TRUE)
), by = player]

# Unir con los minutos
extras <- merge(extras, tiempos_por_jugador, by = "player", all.x = TRUE)


# 4) Armar ranking combinado
ranking <- merge(acumulados[, .(player, nac, pct_1st_serve_won, pct_2nd_serve_won)],
                 otras_metricas, by = "player", all.x = TRUE)
ranking <- merge(ranking, extras, by = "player", all.x = TRUE)

# --- Parte 2: Crear imágenes individuales top‑5 ---

nombres_amigables <- c(
  pct_1st_serve_won = "% Ptos Ganados 1º Saque",
  pct_2nd_serve_won = "% Ptos Ganados 2º Saque",
  pct_bp_saved = "% BP Salvados",
  pct_bp_converted = "% BP Convertidos",
  pct_return_1st = "% Ganados al resto 1º Saque",
  pct_return_2nd = "% Ganados al resto 2º Saque",
  pct_total_points_serve = "% Ptos Ganados al Saque",
  pct_total_points_return = "% Ptos Ganados al Resto",
  pct_total_points = "% Puntos Ganados",
  pct_aces_df = "Rate Aces/DF",
  pct_winners_ue = "Rate Winners/ENF",
  pct_net_points = "% Ptos Ganados en la red",
  aces_totales = "Aces Totales",
  dobles_faltas_totales = "Dobles Faltas Totales",
  tiempo_total_min = "Tiempo Total (min)"
)

dir.create("/Users/paula/Documents/TennisData/TennisCodes/Metricas", showWarnings = FALSE)

for (metrica in metricas) {
  top_n <- ranking[order(-get(metrica)), .(Jugador = player, Valor = round(get(metrica), 2))]
  top_n <- top_n[1:min(5, .N)]
  if (nrow(top_n) < 5) {
    faltantes <- 5 - nrow(top_n)
    relleno <- data.table(Jugador = rep("-", faltantes), Valor = rep("-", faltantes))
    top_n <- rbind(top_n, relleno)
  }
  tg <- tableGrob(top_n, rows = NULL)
  
  bg_idx1 <- which(tg$layout$t == 1 & tg$layout$l == 1 & grepl("background|bg", tg$layout$name))
  bg_idx2 <- which(tg$layout$t == 1 & tg$layout$l == 2 & grepl("background|bg", tg$layout$name))
  if (length(bg_idx1) > 0) tg$grobs[[bg_idx1]]$gp$fill <- "#98b8d9"
  if (length(bg_idx2) > 0) tg$grobs[[bg_idx2]]$gp$fill <- "#98b8d9"
  
  header_idx <- which(tg$layout$t == 1 & tg$layout$name == "colhead-fg")
  if (length(header_idx) > 0) {
    for (i in header_idx) tg$grobs[[i]]$gp <- gpar(col = "#004c72", fontface = "bold")
  }
  
  for (i in grep("col1", tg$layout$name)) {
    tg$grobs[[i]]$just <- "right"; tg$grobs[[i]]$x <- unit(0.95, "npc")
    tg$grobs[[i]]$gp <- gpar(col = "#004c72")
  }
  for (i in grep("col2", tg$layout$name)) {
    tg$grobs[[i]]$just <- "left"; tg$grobs[[i]]$x <- unit(0.05, "npc")
    tg$grobs[[i]]$gp <- gpar(col = "#004c72")
  }
  
  for (i in grep("line", tg$layout$name)) tg$grobs[[i]] <- nullGrob()
  tg$widths <- unit.c(unit(150, "pt"), unit(80, "pt"))
  
  title <- textGrob(nombres_amigables[metrica],
                    gp = gpar(fontsize = 16, fontface = "bold", col = "#004c72"))
  tg <- gtable_add_rows(tg, heights = grobHeight(title) + unit(6, "mm"), pos = 0)
  tg <- gtable_add_grob(tg, title, t = 1, l = 1, r = ncol(tg))
  
  png(file.path("/Users/paula/Documents/TennisData/TennisCodes/Metricas",
                paste0(metrica, "_top5.png")),
      width = 1000, height = 650, res = 300)
  grid.draw(tg); dev.off()
}

# --- Parte 3: Función mosaico 3×2 y creación de imágenes finales ---

combinar_metricas <- function(metrica_vector, nombre_salida,
                              carpeta = "/Users/paula/Documents/TennisData/TennisCodes/Metricas") {
  imgs <- lapply(metrica_vector, function(m)
    readPNG(file.path(carpeta, paste0(m, "_top5.png"))))
  
  img_h <- 650; img_w <- 1000
  png(file.path(carpeta, nombre_salida),
      width = img_w * 2, height = img_h * 3, res = 300)
  grid.newpage()
  pushViewport(viewport(layout = grid.layout(3, 2,
                                             widths = unit(rep(1, 2), "null"),
                                             heights = unit(rep(1, 3), "null"))))
  for (i in seq_along(imgs)) {
    r <- ceiling(i / 2); c <- ifelse(i %% 2 == 1, 1, 2)
    grid.draw(rasterGrob(imgs[[i]], vp = viewport(layout.pos.row = r,
                                                  layout.pos.col = c)))
  }
  grid.lines(x = unit(c(0,1), "npc"), y = unit(c(2/3,2/3), "npc"),
             gp = gpar(col="#004c72", lwd=2))
  grid.lines(x = unit(c(0,1), "npc"), y = unit(c(1/3,1/3), "npc"),
             gp = gpar(col="#004c72", lwd=2))
  grid.lines(x = unit(c(0.5,0.5), "npc"), y = unit(c(0,1), "npc"),
             gp = gpar(col="#004c72", lwd=2))
  dev.off()
}

# Crear las dos imágenes 3×2 como querés:
combinar_metricas(c(
  "pct_1st_serve_won", "pct_2nd_serve_won", "pct_bp_saved",
  "pct_bp_converted", "pct_return_1st", "pct_return_2nd"
), "metricas_img1.png")

combinar_metricas(c(
  "pct_total_points_serve", "pct_total_points_return", "pct_total_points",
  "aces_totales", "dobles_faltas_totales", "tiempo_total_min"
), "metricas_img2.png")
