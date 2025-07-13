library(data.table)

folder_path <- "C:/Users/Paula/Documents/Projects/TennisData/ATP_ranking/rank_years/"
file_list <- list.files(path = folder_path, pattern = "*.csv", full.names = TRUE)
db <- rbindlist(lapply(file_list, fread), fill = TRUE)


arg <- db [country == 'ARG' & player=='Francisco Comesana']



###########################################################################################################

library(data.table)

start_date <- as.Date("1980-01-01")
end_date <- Sys.Date()

# Crear una secuencia de fechas
dates <- seq.Date(from = start_date, to = end_date, by = "day")

# Crear el data.table
dt <- data.table(
  Date = format(dates, "%Y%m%d"),
  DayOfWeek = weekdays(dates)
)


dt[, Date := as.character(Date)]

# Convertir la columna 'date' en arg a formato character
arg[, date := as.character(date)]

# Convertir las columnas de texto a formato Date
dt[, Date := as.Date(Date, format = "%Y%m%d")]
arg[, date := as.Date(date, format = "%Y%m%d")]

# Realizar la fusión de los data.tables
merged_dt <- merge(dt, arg, by.x = "Date", by.y = "date", all.x = TRUE)

# Reordenar las columnas si es necesario (por ejemplo, para poner las columnas de arg al final)
setcolorder(merged_dt, c("Date", setdiff(names(dt), "Date"), setdiff(names(arg), "date")))


data <- merged_dt
setDT(data)

# Asegurarse de que la columna rank sea numérica
data[, rank := as.numeric(rank)]

# Reemplazar valores NA con el último valor conocido para los lunes (regla de 8 días)
data[, rank_filled := nafill(rank, type = "locf")]

# Filtrar por rank <= 100
weeks_in_top_100 <- data[rank_filled <= 100 & DayOfWeek == "lunes", .N]


