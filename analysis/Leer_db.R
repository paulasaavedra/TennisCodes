
# Cargar librerías
library(DBI)
library(RMariaDB)
library(data.table)

# Establecer la conexión
con <- dbConnect(
  MariaDB(), 
  dbname = "tennis_db",
  host = "localhost", 
  user = "root", 
  password = "tennis46" 
)

# Listar tablas disponibles
dbListTables(con)

# Leo atp_simple
setnames(db <- setDT(dbReadTable(con, "atp_simple")), tolower(names(db)))

# setnames(pbyp <- setDT(dbReadTable(con, "atp_pbyp")), tolower(names(pbyp)))
# setnames(rank <- setDT(dbReadTable(con, "atp_rankings")), tolower(names(rank)))

setnames(db_stats_w_t <- setDT(dbReadTable(con, "atp_stats_w_t")), tolower(names(db_stats_w_t)))
setnames(db_stats_l_t <- setDT(dbReadTable(con, "atp_stats_l_t")), tolower(names(db_stats_l_t)))


# Cerrar la conexión
dbDisconnect(con)
