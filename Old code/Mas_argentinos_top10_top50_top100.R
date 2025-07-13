library(data.table)

# Asegurate de que 'rank' sea un data.table
setDT(rank)

# Paso 1-3: Filtramos argentinos en el top 10 y contamos por semana
arg_top10 <- rank[country == "ARG" & rank_position <= 10, .N, by = date_rank]

arg_top50 <- rank[country == "ARG" & rank_position <= 50, .N, by = date_rank]

arg_top100 <- rank[country == "ARG" & rank_position <= 100, .N, by = date_rank]


