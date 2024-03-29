oriT.F <-
function(Feat, SQuali, SQualiN){
  Item <- c("/allele=", "/bound_moiety=", "/citation=", "/db_xref=", "/direction=", "/experiment=", "/gene=", "/gene_synonym=", "/inference=", "/locus_tag=", "/map=", "/note=", "/old_locus_tag=", "/rpt_family=", "/rpt_type=", "/rpt_unit_range=", "/rpt_unit_seq=", "/standard_name=")
  ItemN <- c("allele", "bound_moiety", "citation", "db_xref", "direction", "experiment", "gene", "gene_synonym", "inference", "locus_tag", "map", "note", "old_locus_tag", "rpt_family", "rpt_type", "rpt_unit_range", "rpt_unit_seq", "standard_name")
  Feat[length(Feat)] <- gsub("\\\",$", "", Feat[length(Feat)])
  oriT <- data.frame("Location" = "oriT", "Qualifier" = gsub(".*oriT +([^.]+)\"*", "\\1", Feat[1], perl = T), stringsAsFactors = F)
  for(i in 2:length(Feat)){
    for(j in 1:length(Item)){
      if(length(grep(Item[j], Feat[i], perl = T)) == 1){
        oriT <- rbind(oriT, c(ItemN[j],  gsub(".*=([^.]+)\"*", "\\1", Feat[i])))
        if((length(grep("\\\\\"$|\"\\\", $|\\d$", Feat[i])) == 0 & i != length(Feat)) == T){
          t <- i+1
          while(length(grep("\\\\\"$|\"\\\", $|\\d$", Feat[t])) == 0 && t <= length(Feat)){
            oriT[dim(oriT)[1],2] <- paste(oriT[dim(oriT)[1],2], gsub("\\s", " ", Feat[t]), sep = " ")
            t <- t+1
          }
          if(length(grep("\\\\\"$|\"\\\", $|\\d$", Feat[t])) == 1){
            oriT[dim(oriT)[1],2] <- paste(oriT[dim(oriT)[1],2], gsub("\\s", " ", Feat[t]), sep = " ")
          }
        }
      }
    }
    for(k in 1:length(SQuali)){
      if(length(grep(SQuali[k], Feat[i], perl = T)) == 1){
        oriT <- rbind(oriT, c(SQuali[k], SQualiN[k]))
      }
    }
  }
  oriT <- apply(oriT, 2, function(x){gsub(" {2,}", " ", x, perl = TRUE)})
  oriT <- apply(oriT, 2, function(x){gsub("\"", "", x, fixed = T)})
  oriT <- apply(oriT, 2, function(x){gsub("\\", "", x, fixed = T)})
  oriT <- apply(oriT, 2, function(x){gsub("[^[:alnum:][:space:][]'.,:_<>()-]", "", x, perl = TRUE)})
  return(oriT)
}
