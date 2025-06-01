library(dplyr)
library(tidyr)
library(data.table)

# Filtramos dataset base
dbm <- db[date_match > "2024-12-20" & tourney_name == 'Roland Garros']
# db <- db[!round_match %in% c('Q1', 'Q2', 'Q3')]

# Hacemos el merge con stats
dbm <- merge(dbm, db_stats_l_t, by = "match_id", all.x = TRUE)
dbm <- merge(dbm, db_stats_w_t, by = "match_id", all.x = TRUE)

# Jugadores que ganaron al menos un partido
ganadores <- unique(dbm$w_player)
perdedores <- unique(dbm$l_player)
invictos <- setdiff(ganadores, perdedores)
dbm <- dbm[w_player %in% invictos]

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

# Unir todo
long_stats <- rbind(w_stats, l_stats, fill = TRUE)


# Convertimos a numérico por seguridad
num_cols <- setdiff(names(long_stats), c("player", "nac", "result"))
long_stats[, (num_cols) := lapply(.SD, as.numeric), .SDcols = num_cols]

# Cálculos de métricas
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

metricas <- c(
  "pct_1st_serve_won", "pct_2nd_serve_won", "pct_aces_df",
  "pct_winners_ue", "pct_bp_saved", "pct_bp_converted",
  "pct_return_1st", "pct_return_2nd", "pct_total_points",
  "pct_total_points_serve", "pct_total_points_return",
  "pct_net_points"
)

# Promediar por jugador
ranking <- long_stats[, lapply(.SD, mean, na.rm = TRUE), by = .(player, nac), .SDcols = metricas]



library(gridExtra)
library(grid)
library(data.table)
library(gtable)

# Nombres amigables para las métricas
nombres_amigables <- c(
  pct_1st_serve_won = "% Ptos Ganados 1° saque",
  pct_2nd_serve_won = "% Ptos Ganados 2° saque",
  pct_aces_df = "Rate Aces/DF",
  pct_winners_ue = "Rate Winners/ENF",
  pct_bp_saved = "% BP Salvados",
  pct_bp_converted = "% BP Convertidos",
  pct_return_1st = "% Ganados al resto 1° Saque",
  pct_return_2nd = "% Ganados al resto 2° Saque",
  pct_total_points = "% Puntos Ganados",
  pct_total_points_serve = "% Ptos Ganados al Saque",
  pct_total_points_return = "% Ptos Ganados al Resto",
  pct_net_points = "% Ptos Ganados en la red"
)

# Crear tablas top 5
top5_metricas <- lapply(metricas, function(m) {
  ranking[order(-get(m))][1:5, .(Jugador = player, Valor = round(get(m), 2))]
})
names(top5_metricas) <- metricas

# Carpeta para guardar imágenes
dir.create("imagenes_top5_metricas", showWarnings = FALSE)

for (metrica in metricas) {
  tabla <- top5_metricas[[metrica]]
  
  # Crear tableGrob sin filas de nombres (rows = NULL)
  tg <- tableGrob(tabla, rows = NULL)
  
  # Eliminar líneas (bordes)
  line_grobs <- grep("line", tg$layout$name)
  for (i in line_grobs) {
    tg$grobs[[i]] <- nullGrob()
  }
  
  # Ajustar ancho fijo para columnas (ajustar valores según necesidad)
  # Ejemplo: primera columna 400 pts, segunda 300 pts
  tg$widths <- unit.c(unit(150, "pt"), unit(80, "pt"))
  
  # Alinear texto: 
  # Jugador (col 1) a la derecha
  idx_col1 <- grep("col1", tg$layout$name)
  for (i in idx_col1) {
    tg$grobs[[i]]$just <- "right"
    tg$grobs[[i]]$x <- unit(0.95, "npc")  # Ajusta la posición horizontal
  }
  
  # Valor (col 2) a la izquierda
  idx_col2 <- grep("col2", tg$layout$name)
  for (i in idx_col2) {
    tg$grobs[[i]]$just <- "left"
    tg$grobs[[i]]$x <- unit(0.05, "npc")
  }
  
  # Añadir fila título que abarca ambas columnas
  title <- textGrob(nombres_amigables[metrica], gp = gpar(fontsize = 16, fontface = "bold"))
  tg <- gtable_add_rows(tg, heights = grobHeight(title) + unit(6, "mm"), pos = 0)
  tg <- gtable_add_grob(tg, title, t = 1, l = 1, r = ncol(tg))
  
  # Guardar con tamaño fijo y alta resolución
  png(
    filename = file.path("imagenes_top5_metricas", paste0(metrica, "_top5.png")),
    width = 1000, height = 650, res = 300
  )
  grid.draw(tg)
  dev.off()
}

library(grid)
library(png)

# Supongamos que quieres combinar estas 4 métricas (puedes cambiar nombres)
metricas_a_combinar <- metricas[1:4]  # las primeras 4 como ejemplo

# Leer las 4 imágenes ya generadas
imgs <- lapply(metricas_a_combinar, function(m) {
  img_path <- file.path("imagenes_top5_metricas", paste0(m, "_top5.png"))
  readPNG(img_path)
})

# Crear archivo PNG para la combinación final
png("imagenes_top5_metricas/combined_4_top5.png", width = 2000, height = 1400, res = 300)

grid.newpage()

# Definir viewport para cada cuadrante
pushViewport(viewport(layout = grid.layout(2, 2)))

# Función para colocar imagen en celda (fila, col)
draw_img_in_cell <- function(img, row, col) {
  print(
    rasterGrob(img),
    vp = viewport(layout.pos.row = row, layout.pos.col = col)
  )
}

# Dibujar cada imagen en un cuadrante 2x2
for (i in seq_along(imgs)) {
  row <- ifelse(i <= 2, 1, 2)
  col <- ifelse(i %% 2 == 1, 1, 2)
  draw_img_in_cell(imgs[[i]], row, col)
}

# Ahora dibujamos las líneas para separar cuadrantes:

# Línea vertical (en mitad horizontal del canvas)
grid.lines(x = unit(c(0.5, 0.5), "npc"), y = unit(c(0, 1), "npc"),
           gp = gpar(col = "black", lwd = 2))

# Línea horizontal (en mitad vertical del canvas)
grid.lines(x = unit(c(0, 1), "npc"), y = unit(c(0.5, 0.5), "npc"),
           gp = gpar(col = "black", lwd = 2))

dev.off()
