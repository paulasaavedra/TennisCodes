library(dplyr)
library(tidyr)
library(data.table)
library(gridExtra)
library(grid)
library(gtable)
library(png)

# --- Parte 1: Preparar datos y calcular métricas ---

# Filtrar dataset base
dbm <- db[date_match > "2024-12-20" & tourney_name == 'Roland Garros']

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

# Unir en formato largo
long_stats <- rbind(w_stats, l_stats, fill = TRUE)

# Convertimos a numérico
num_cols <- setdiff(names(long_stats), c("player", "nac", "result"))
long_stats[, (num_cols) := lapply(.SD, as.numeric), .SDcols = num_cols]

# Cálculo de métricas
long_stats[, `:=`(
  pct_1st_serve_won = 100 * `1st_serve_points_won` / `1st_serve_points_played`,
  pct_2nd_serve_won = 100 * `2nd_serve_points_won` / `2nd_serve_points_played`,
  pct_aces_df = 100 * aces / (`aces` + `double_faults`),
  pct_winners_ue = 100 * winners / (`winners` + `unforced_errors`),
  pct_bp_saved = `break_points_saved_percentage`,
  pct_bp_converted = `break_points_converted_percentage`,
  pct_return_1st = `1st_return_points_won_percentage`,
  pct_return_2nd = `2nd_return_points_won_percentage`,
  pct_total_points = `total_points_won_percentage`,
  pct_total_points_serve = 100 * `service_points_won` / `service_points_played`,
  pct_total_points_return = 100 * `return_points_won` / `return_points_played`,
  pct_net_points = `net_points_won_percentage`
)]

# Identificar jugadores invictos
ganadores <- unique(dbm$w_player)
perdedores <- unique(dbm$l_player)
invictos <- setdiff(ganadores, perdedores)

# Filtrar solo métricas de jugadores invictos
long_stats <- long_stats[player %in% invictos]

# Métricas a promediar
metricas <- c(
  "pct_1st_serve_won", "pct_2nd_serve_won", "pct_aces_df",
  "pct_winners_ue", "pct_bp_saved", "pct_bp_converted",
  "pct_return_1st", "pct_return_2nd", "pct_total_points",
  "pct_total_points_serve", "pct_total_points_return",
  "pct_net_points"
)

# Promediar métricas por jugador
ranking <- long_stats[, lapply(.SD, mean, na.rm = TRUE), by = .(player, nac), .SDcols = metricas]

# --- Parte 2: Crear imágenes individuales top5 para cada métrica ---

nombres_amigables <- c(
  pct_1st_serve_won = "% Ptos Ganados 1° saque",
  pct_2nd_serve_won = "% Ptos Ganados 2° saque",
  pct_aces_df = "Rate Aces/DF",
  pct_winners_ue = "Rate Winners/ENF",
  pct_bp_saved = "% BP Salvados",
  pct_bp_converted = "% BP Convertidos",
  pct_return_1st = "% Ganados al resto 1° Saque",
  pct_return_2nd = "% Ganados al resto 2° Saque",
  pct_total_points_serve = "% Ptos Ganados al Saque",
  pct_total_points_return = "% Ptos Ganados al Resto",
  pct_net_points = "% Ptos Ganados en la red",
  pct_total_points = "% Puntos Ganados"
)

dir.create("/Users/paula/Documents/TennisData/TennisCodes/Metricas", showWarnings = FALSE)

for (metrica in metricas) {
  # Extraer top 5 jugadores o menos
  top_n <- ranking[order(-get(metrica)), .(Jugador = player, Valor = round(get(metrica), 2))]
  top_n <- top_n[1:min(5, .N)]
  
  # Completar filas si hay menos de 5 jugadores
  if (nrow(top_n) < 5) {
    faltantes <- 5 - nrow(top_n)
    relleno <- data.table(Jugador = rep("-", faltantes), Valor = rep("-", faltantes))
    tabla <- rbind(top_n, relleno)
  } else {
    tabla <- top_n
  }
  
  tg <- tableGrob(tabla, rows = NULL)
  
  # Fondo del encabezado
  idx_bg_col1 <- which(tg$layout$t == 1 & tg$layout$l == 1 & grepl("background|bg", tg$layout$name))
  idx_bg_col2 <- which(tg$layout$t == 1 & tg$layout$l == 2 & grepl("background|bg", tg$layout$name))
  if(length(idx_bg_col1) > 0) tg$grobs[[idx_bg_col1]]$gp$fill <- "#98b8d9"
  if(length(idx_bg_col2) > 0) tg$grobs[[idx_bg_col2]]$gp$fill <- "#98b8d9"
  
  # Texto del encabezado
  header_text_idx <- which(tg$layout$t == 1 & tg$layout$name == "colhead-fg")
  if(length(header_text_idx) > 0) {
    for(i in header_text_idx) {
      tg$grobs[[i]]$gp <- gpar(col = "#004c72", fontface = "bold")
    }
  }
  
  # Estilo de texto por columnas
  idx_col1 <- grep("col1", tg$layout$name)
  for (i in idx_col1) {
    tg$grobs[[i]]$just <- "right"
    tg$grobs[[i]]$x <- unit(0.95, "npc")
    tg$grobs[[i]]$gp <- gpar(col = "#004c72")
  }
  
  idx_col2 <- grep("col2", tg$layout$name)
  for (i in idx_col2) {
    tg$grobs[[i]]$just <- "left"
    tg$grobs[[i]]$x <- unit(0.05, "npc")
    tg$grobs[[i]]$gp <- gpar(col = "#004c72")
  }
  
  # Quitar líneas
  line_grobs <- grep("line", tg$layout$name)
  for (i in line_grobs) {
    tg$grobs[[i]] <- nullGrob()
  }
  
  # Ancho fijo
  tg$widths <- unit.c(unit(150, "pt"), unit(80, "pt"))
  
  # Añadir título
  title <- textGrob(
    nombres_amigables[metrica],
    gp = gpar(fontsize = 16, fontface = "bold", col = "#004c72")
  )
  
  tg <- gtable_add_rows(tg, heights = grobHeight(title) + unit(6, "mm"), pos = 0)
  tg <- gtable_add_grob(tg, title, t = 1, l = 1, r = ncol(tg))
  
  # Guardar imagen
  png(
    filename = file.path("/Users/paula/Documents/TennisData/TennisCodes/Metricas", paste0(metrica, "_top5.png")),
    width = 1000, height = 650, res = 300
  )
  grid.draw(tg)
  dev.off()
}

# --- Parte 3: Función para combinar imágenes en mosaico 3x2 ---

combinar_metricas <- function(metrica_vector, nombre_salida, carpeta = "/Users/paula/Documents/TennisData/TennisCodes/Metricas") {
  imgs <- lapply(metrica_vector, function(m) {
    img_path <- file.path(carpeta, paste0(m, "_top5.png"))
    readPNG(img_path)
  })
  
  img_height_px <- 650
  img_width_px <- 1000
  combined_height <- img_height_px * 3
  combined_width <- img_width_px * 2
  
  png(filename = file.path(carpeta, nombre_salida),
      width = combined_width,
      height = combined_height,
      res = 300)
  
  grid.newpage()
  pushViewport(viewport(layout = grid.layout(3, 2,
                                             widths = unit(rep(1, 2), "null"),
                                             heights = unit(rep(1, 3), "null"))))
  
  draw_img_in_cell <- function(img, row, col) {
    grid.draw(rasterGrob(img, vp = viewport(layout.pos.row = row, layout.pos.col = col)))
  }
  
  for (i in seq_along(imgs)) {
    row <- ceiling(i / 2)
    col <- ifelse(i %% 2 == 1, 1, 2)
    draw_img_in_cell(imgs[[i]], row, col)
  }
  
  # Líneas divisorias
  grid.lines(x = unit(c(0, 1), "npc"), y = unit(c(2/3, 2/3), "npc"), gp = gpar(col = "#004c72", lwd = 2))
  grid.lines(x = unit(c(0, 1), "npc"), y = unit(c(1/3, 1/3), "npc"), gp = gpar(col = "#004c72", lwd = 2))
  grid.lines(x = unit(c(0.5, 0.5), "npc"), y = unit(c(0, 1), "npc"), gp = gpar(col = "#004c72", lwd = 2))
  
  dev.off()
}

# --- Parte 4: Crear dos imágenes combinadas con 6 métricas cada una ---

combinar_metricas(metricas[1:6], "metricas_1_6.png")
combinar_metricas(metricas[7:12], "metricas_7_12.png")


