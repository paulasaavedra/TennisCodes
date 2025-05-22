library(dplyr)
library(tidyr)
library(kableExtra)
library(stringr)


dbm <- db [tourney_level!='CH']
dbm <- dbm [match_status!= 'Walkover']
dbm <- dbm [round_match != 'Q1' & round_match != 'Q2' & round_match != 'Q3']
dbm[, match_id := sub("_\\d+$", "", match_id)]

dbm <- dbm %>%
  separate(match_id, into = c("year", "id"), sep = "_")

setDT(dbm)

dbm[, match_score_clean := gsub("\\(\\d+\\)", "", score)]

dbm <- dbm [year ==2025]

dbm <- dbm[best==3]


dbm <- dbm %>%
  mutate(
    sets = strsplit(match_score_clean, " "),
    Dado_vuelta = sapply(sets, function(set) {
      # Verificamos que haya al menos 3 sets
      if (length(set) >= 3) {
        # Intentamos extraer los sets de forma segura
        s1 <- suppressWarnings(as.numeric(unlist(strsplit(set[1], "-"))))
        s2 <- suppressWarnings(as.numeric(unlist(strsplit(set[2], "-"))))
        s3 <- suppressWarnings(as.numeric(unlist(strsplit(set[3], "-"))))
        
        # Verificamos que cada set tenga dos números válidos
        if (
          length(s1) == 2 && length(s2) == 2 && length(s3) == 2 &&
          all(!is.na(c(s1, s2, s3)))
        ) {
          if (s1[1] < s1[2] && s2[1] > s2[2] && s3[1] > s3[2]) {
            return("SI")
          }
        }
      }
      return("NO")
    })
  )

remontados <- dbm [Dado_vuelta=='SI']
remontados <- remontados[,.N,by=l_player]
