library(dplyr)
library(tidyr)


dbm <- db [tourney_level != 'CH' & match_status != 'Walkover']

dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']

dbm[, bagel := fifelse(startsWith(score, "6-0"), "G",
                      fifelse(startsWith(score, "0-6"), "P", "NO"))]

first_bagel <- dbm[bagel!='NO']

# Cantidad de ganados y perdidos
bagel_counts <- first_bagel[, .N, by = bagel]

# Total de filas no NA
total_bagels <- first_bagel[!is.na(bagel), .N]

# Agregamos la columna de porcentaje
bagel_counts[, porcentaje := round(100 * N / total_bagels, 2)]



# Bagels porcentaje por año
library(data.table)

# Extraer el año desde la columna date_match
first_bagel[, year := year(as.IDate(date_match))]

# Contar cantidad de G y P por año
bagel_by_year <- first_bagel[, .N, by = .(year, bagel)]

# Calcular total por año
bagel_by_year[, total := sum(N), by = year]

# Calcular porcentaje por año
bagel_by_year[, porcentaje := round(100 * N / total, 2)]

# Resultado
print(bagel_by_year[order(year)])


#Bagels porcentaje por superficie y año

# Asegurarse de que la fecha esté en formato Date
first_bagel[, year := year(as.IDate(date_match))]

# Contar cantidad de G y P por año y superficie
bagel_year_surface <- first_bagel[, .N, by = .(year, surface, bagel)]

# Calcular total por año y superficie
bagel_year_surface[, total := sum(N), by = .(year, surface)]

# Calcular porcentaje
bagel_year_surface[, porcentaje := round(100 * N / total, 2)]

# Ver resultado
print(bagel_year_surface[order(year, surface)])

