library(ggplot2)
## for a mouse sample
wgs_fp <- read.table("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\abundence\\WGS\\human_2_wgs.genus.bracken", sep='\t', head=T)
#final_df <- data.frame(method=character(), name=character(), frac=double())
total_read_wgs <- sum(wgs_fp$new_est_reads)
frac_wgs <- wgs_fp$new_est_reads / total_read_wgs

wgs_data <- data.frame(name=wgs_fp$name, frac=frac_wgs)
#wgs_data <- arrange(wgs_data, -frac)
wgs_data <- wgs_data[order(-wgs_data$frac),]
wgs_data$method="WGS"

lfr_fp <- read.table("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\abundence\\stLFR\\human_2_stlfr_add.genus.bracken", sep='\t', head=T)
total_read_lfr <- sum(lfr_fp$new_est_reads)
frac_lfr <- lfr_fp$new_est_reads / total_read_lfr

lfr_data <- data.frame(name=lfr_fp$name, frac=frac_lfr)
#lfr_data <- arrange(lfr_data, -frac)
lfr_data <- lfr_data[order(-lfr_data$frac),]
lfr_data$method="stLFR"

final_df <- rbind(wgs_data[1:10,], lfr_data[1:10,])
final_df[nrow(final_df)+1,] <- c("Other", sum(wgs_data$frac[-(1:10)]), "WGS")
final_df[nrow(final_df)+1,] <- c("Other", sum(lfr_data$frac[-(1:10)]), "stLFR")
final_df$frac <- as.double(final_df$frac)
p1<-ggplot(final_df, aes(x=method, y=frac, fill=name)) + 
    labs(title="", x="", y="relative abundance", fill="") +
    geom_col(position="stack") +
    theme(legend.position="right", legend.key.size=unit(1, "lines"))

p1