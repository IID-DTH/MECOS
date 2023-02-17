library(ggplot2)
#pdf('nimei.pdf')
#layout(matrix(1:4, 2,2))
wgs_fp <- read.table("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\abundence\\WGS\\human_1_wgs.genus.bracken", sep='\t', head=T)
#final_df <- data.frame(method=character(), name=character(), frac=double())
total_read_wgs <- sum(wgs_fp$new_est_reads)
frac_wgs <- wgs_fp$new_est_reads / total_read_wgs

wgs_data <- data.frame(name=wgs_fp$name, frac=frac_wgs)
#wgs_data <- arrange(wgs_data, -frac)
wgs_data <- wgs_data[order(-wgs_data$frac),]
wgs_data$method="WGS"

lfr_fp <- read.table("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\abundence\\stLFR\\human_1_stlfr.genus.bracken", sep='\t', head=T)
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
    theme(legend.position="right", legend.key.size=unit(0.5, "lines"))


## for a mouse sample
wgs_fp <- read.table("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\abundence\\WGS\\mouse_1_wgs.genus.bracken", sep='\t', head=T)
#final_df <- data.frame(method=character(), name=character(), frac=double())
total_read_wgs <- sum(wgs_fp$new_est_reads)
frac_wgs <- wgs_fp$new_est_reads / total_read_wgs

wgs_data <- data.frame(name=wgs_fp$name, frac=frac_wgs)
#wgs_data <- arrange(wgs_data, -frac)
wgs_data <- wgs_data[order(-wgs_data$frac),]
wgs_data$method="WGS"

lfr_fp <- read.table("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\abundence\\stLFR\\mouse_1_stlfr.genus.bracken", sep='\t', head=T)
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
p2<-ggplot(final_df, aes(x=method, y=frac, fill=name)) + 
    labs(title="", x="", y="relative abundance", fill="") +
    geom_col(position="stack") +
    theme(legend.position="right", legend.key.size=unit(0.5, "lines"))



#sp_N50_h1_athena<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\Human_meta_1_athena.sp_N50",header=F)
sp_N50_h1_athena<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\human_1_athena.sp_N50",header=F)

colnames(sp_N50_h1_athena)=c("species","contig_count","length_sum","N50")
sp_N50_h1_athena$method="stLFR_Athena"

sp_N50_h1_st_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\H1_spa.sp_N50",header=F)
colnames(sp_N50_h1_st_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_st_spa$method="stLFR_SPAdes"

sp_N50_h1_wgs_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\H1wgs_spa.sp_N50",header=F)
colnames(sp_N50_h1_wgs_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_wgs_spa$method="WGS_SPAdes"

sp_N50_h1=rbind(sp_N50_h1_athena,sp_N50_h1_st_spa,sp_N50_h1_wgs_spa)
sp_N50_h1$sp=apply(sp_N50_h1,1,function(a){
  b=strsplit(as.character(a["species"]),split="|",fixed=T)[[1]];
  b[length(b)]})
sp_N50_h1$sp <- as.character(sp_N50_h1$sp)

select_sp=c("s__Bacteroides_caccae",
"s__Bacteroides_cellulosilyticus",
"s__Bacteroides_ovatus",
"s__Bacteroides_thetaiotaomicron",
"s__Bacteroides_vulgatus",
"s__Bifidobacterium_adolescentis",
"s__Bifidobacterium_longum",
"s__Escherichia_coli",
"s__[Eubacterium]_rectale",
"s__Odoribacter_splanchnicus",
"s__Roseburia_hominis",
"s__Ruminococcus_bicirculans",
"s__Streptococcus_salivarius"
)
top10_sp=subset(sp_N50_h1,sp %in% select_sp)
top10_sp$sp=gsub("s__", "", top10_sp$sp)
top10_sp$sp=gsub("_", " ", top10_sp$sp)
order_sp=as.character(unique(top10_sp[order(top10_sp$N50,decreasing = T),"sp"]))
p3<-ggplot(top10_sp,aes(x=sp,y=N50))+geom_point(aes(col=method,shape=method))+
    labs(title="", x="", y="N50", shape="", col="") +
    coord_flip()+xlim(rev(order_sp))


# mouse_1
sp_N50_h1_athena<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\mouse_1_athena.sp_N50",header=F)
colnames(sp_N50_h1_athena)=c("species","contig_count","length_sum","N50")
sp_N50_h1_athena$method="stLFR_Athena"

sp_N50_h1_st_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\M1_spa.sp_N50",header=F)
colnames(sp_N50_h1_st_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_st_spa$method="stLFR_SPADE"

sp_N50_h1_wgs_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\M1wgs_spa.sp_N50",header=F)
colnames(sp_N50_h1_wgs_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_wgs_spa$method="WGS_SPADE"

sp_N50_h1=rbind(sp_N50_h1_athena,sp_N50_h1_st_spa,sp_N50_h1_wgs_spa)
sp_N50_h1$sp=apply(sp_N50_h1,1,function(a){
  b=strsplit(as.character(a["species"]),split="|",fixed=T)[[1]];
  b[length(b)]})
sp_N50_h1$sp <- as.character(sp_N50_h1$sp)

select_sp=c("s__Akkermansia_muciniphila",
"s__Enterococcus_faecalis",
"s__Escherichia_coli",
"s__Helicobacter_bilis",
"s__Proteus_mirabilis")
top10_sp=subset(sp_N50_h1,sp %in% select_sp)
top10_sp$sp=gsub("s__", "", top10_sp$sp)
top10_sp$sp=gsub("_", " ", top10_sp$sp)
order_sp=as.character(unique(top10_sp[order(top10_sp$N50,decreasing = T),"sp"]))
p4<-ggplot(top10_sp,aes(x=sp,y=N50))+geom_point(aes(col=method,shape=method))+
    labs(title="", x="", y="N50", shape="", col="") +
    coord_flip()+xlim(rev(order_sp))
library(ggpubr)

#ggarrange(p1, p3, p2, p4, ncol=2, nrow=2,
#                labels=c("a", "c", "b", "d"),
#                common.legend=FALSE, align="hv", #widths=c(1,2,1,2),
#                legend="right")

#p5<-ggarrange(p1,p3, ncol=2, labels=c("a", "c"), widths=c(1, 1.5))
#p6<-ggarrange(p2,p4, ncol=2, labels=c("b", "d"), widths=c(1, 1.5))
p7<-ggarrange(p1,p2, nrow=2, labels=c("a", "b"),align="hv")


p8<-ggarrange(p3,p4, nrow=2, labels=c("c", "d"), common.legend=T,
              align="hv", legend="bottom")
#ggarrange(p5, p6, nrow=2, ncol=1)
ggarrange(p7, p8, nrow=1, ncol=2, widths=c(1,1.2))
#dev.off()
