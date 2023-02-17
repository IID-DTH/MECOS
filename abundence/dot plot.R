library(ggplot2)
select_genus <- c("Acetobacterium", 
"Actualibacter", 
"Akkermansia", 
"Alistipes", 
"Bacteroides", 
"Bifidobacterirum", 
"Candidatus Cloacimonas", 
"Escherichia", 
"Eubacterium", 
"Helicobacter", 
"Lachnoclostridium", 
"Lactobacillus", 
"Odoribacter", 
"Other", 
"Parabacteroides", 
"Prevotella", 
"Proteus", 
"Roseburia", 
"Ruminococcus")


wgs_fp <- read.table("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\abundence\\WGS\\Human_meta_1.rmhost.genus.bracken", sep='\t', head=T)
method <- rep("WGS", nrow(wgs_fp))
wgs_data <- cbind(method, wgs_fp)
lfr_fp <- read.table("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\abundence\\stLFR\\Human_meta_1_rmhost_sort.genus.bracken", sep='\t', head=T)
method <- rep("stLFR", nrow(lfr_fp))
lfr_data <- cbind(method, lfr_fp)
data <- rbind(wgs_data, lfr_data)
head(data)
tail(data)

top_genus=subset(data,name %in% select_genus)

#p1<-ggplot(top_genus, aes(x=name, y=fraction_total_reads, color=method, group=method)) + 
#   geom_point(size=0.1) +
#   geom_line(aes(color=method)) +
#   theme_minimal() +
#   theme(axis.text.x = element_text(angle = 60, hjust = 1))
p1<-ggplot(top_genus, aes(x=method, y=fraction_total_reads, fill=name)) + 
    geom_col(position="fill")
p1