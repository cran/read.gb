ncRNA.F <-
function(Feat, SQuali, SQualiN){
  Item <- c("/allele=", "/citation=", "/db_xref=", "/experiment=", "/function=", "/gene=", "/gene_synonym=", "/inference=", "/locus_tag=", "/map=", "/ncRNA_class=", "/note=", "/old_locus_tag=", "/operon=", "/product=", "/pseudogene=", "/standard_name=")
  ItemN <- c("allele", "citation", "db_xref", "experiment", "function", "gene", "gene_synonym", "inference", "locus_tag", "map", "ncRNA_class", "note", "old_locus_tag", "operon", "product", "pseudogene", "standard_name")
  Feat[length(Feat)] <- gsub("\\\",$", "", Feat[length(Feat)])
  ncRNA <- data.frame("Location" = "ncRNA", "Qualifier" = gsub(".*ncRNA +([^.]+)\"*", "\\1", Feat[1], perl = T), stringsAsFactors = F)
  for(i in 2:length(Feat)){
    for(j in 1:length(Item)){
      if(length(grep(Item[j], Feat[i], perl = T)) == 1){
        ncRNA <- rbind(ncRNA, c(ItemN[j],  gsub(".*=([^.]+)\"*", "\\1", Feat[i])))
        if((length(grep("\\\\\"$|\"\\\", $|\\d$", Feat[i])) == 0 & i != length(Feat)) == T){
          t <- i+1
          while(length(grep("\\\\\"$|\"\\\", $|\\d$", Feat[t])) == 0 && t <= length(Feat)){
            ncRNA[dim(ncRNA)[1],2] <- paste(ncRNA[dim(ncRNA)[1],2], gsub("\\s", " ", Feat[t]), sep = " ")
            t <- t+1
          }
          if(length(grep("\\\\\"$|\"\\\", $|\\d$", Feat[t])) == 1){
            ncRNA[dim(ncRNA)[1],2] <- paste(ncRNA[dim(ncRNA)[1],2], gsub("\\s", " ", Feat[t]), sep = " ")
          }
        }
      }
    }
    for(k in 1:length(SQuali)){
      if(length(grep(SQuali[k], Feat[i], perl = T)) == 1){
        ncRNA <- rbind(ncRNA, c(SQuali[k], SQualiN[k]))
      }
    }
  }
  ncRNA <- apply(ncRNA, 2, function(x){gsub(" {2,}", " ", x, perl = TRUE)})
  ncRNA <- apply(ncRNA, 2, function(x){gsub("\"", "", x, fixed = T)})
  ncRNA <- apply(ncRNA, 2, function(x){gsub("\\", "", x, fixed = T)})
  ncRNA <- apply(ncRNA, 2, function(x){gsub("[^[:alnum:][:space:][]'.,:_<>()-]", "", x, perl = TRUE)})
  return(ncRNA)
}
