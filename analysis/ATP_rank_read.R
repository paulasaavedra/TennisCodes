library(data.table)

folder_path <- "C:/Users/Paula/Documents/Projects/TennisData/ATP_ranking/rank_years/"
file_list <- list.files(path = folder_path, pattern = "*.csv", full.names = TRUE)
db <- rbindlist(lapply(file_list, fread), fill = TRUE)
