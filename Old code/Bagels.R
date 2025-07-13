### Bagel por jugador

dbm <- db [tourney_level == 'GS']

score <- '6-0'
reverseScore <- '0-6'
  
dbm$winnerbagel <- str_count(dbm$score, score)
dbm$loserbagel <- str_count(dbm$score, reverseScore)

dbm <- dbm[, c("w_player", "l_player", "winnerbagel", "loserbagel")]

wins <- dbm[, c("w_player", "winnerbagel")]
losses <- dbm[, c("l_player", "loserbagel")]

names(wins)[1] <- names(losses)[1] <- "Player"
names(wins)[2] <- names(losses)[2] <- "Bagel"

wins[is.na(wins)] <- 0
losses[is.na(losses)] <- 0

all <- rbind(wins, losses)

bagel1 <-
  aggregate(all$Bagel,
            by = list(Player = all$Player),
            FUN = sum)
  
  ## order by decreasing
  bagel1 <- setorder(bagel1,-x, na.last = FALSE)


  ## Bagel por torneo
  
  dbm <- db 
  
  score <- '6-0'
  reverseScore <- '0-6'
  
  dbm$winnerbagel <- str_count(dbm$score, score)
  dbm$loserbagel <- str_count(dbm$score, reverseScore)
  
  dbm <- dbm[, c("match_id", "tourney_name", "w_player", "l_player","round_match","winnerbagel", "loserbagel")]
  dbm$total <- dbm$winnerbagel + dbm$loserbagel
  
  resultado <- dbm[, .(total_sum = sum(total, na.rm = TRUE)), by = tourney_name]