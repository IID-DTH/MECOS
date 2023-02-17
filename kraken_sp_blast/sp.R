library(ggplot2)
sp_N50_h1_athena<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\Human_meta_1_athena.sp_N50",header=F)
colnames(sp_N50_h1_athena)=c("species","contig_count","length_sum","N50")
sp_N50_h1_athena$method="stLFR_athena"

sp_N50_h1_st_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\H1_spa.sp_N50",header=F)
colnames(sp_N50_h1_st_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_st_spa$method="stLFR_SPADE"

sp_N50_h1_wgs_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\H1wgs_spa.sp_N50",header=F)
colnames(sp_N50_h1_wgs_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_wgs_spa$method="WGS_SPADE"

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
"s__Odoribacter_splanchnicus",
"s__Roseburia_hominis",
"s__Ruminococcus_bicirculans",
"s__Streptococcus_salivarius")
top10_sp=subset(sp_N50_h1,sp %in% select_sp)
order_sp=as.character(unique(top10_sp[order(top10_sp$N50,decreasing = T),"sp"]))
p1<-ggplot(top10_sp,aes(x=sp,y=N50,col=method,shape=method))+geom_point()+coord_flip()+xlim(rev(order_sp))
p1

# human_2
sp_N50_h1_athena<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\Human_meta_2_athena.sp_N50",header=F)
colnames(sp_N50_h1_athena)=c("species","contig_count","length_sum","N50")
sp_N50_h1_athena$method="stLFR_athena"

sp_N50_h1_st_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\H2_spa.sp_N50",header=F)
colnames(sp_N50_h1_st_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_st_spa$method="stLFR_SPADE"

sp_N50_h1_wgs_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\H2wgs_spa.sp_N50",header=F)
colnames(sp_N50_h1_wgs_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_wgs_spa$method="WGS_SPADE"

sp_N50_h1=rbind(sp_N50_h1_athena,sp_N50_h1_st_spa,sp_N50_h1_wgs_spa)
sp_N50_h1$sp=apply(sp_N50_h1,1,function(a){
  b=strsplit(as.character(a["species"]),split="|",fixed=T)[[1]];
  b[length(b)]})
sp_N50_h1$sp <- as.character(sp_N50_h1$sp)

select_sp=c("s__Alistipes_finegoldii",
"s__Anaerostipes_hadrus",
"s__Bacteroides_fragilis",
"s__Bacteroides_ovatus",
"s__Bacteroides_thetaiotaomicron",
"s__Bacteroides_vulgatus",
"s__Bifidobacterium_adolescentis",
"s__Bifidobacterium_longum",
"s__Bifidobacterium_pseudocatenulatum",
"s__Escherichia_coli",
"s__Flavonifractor_plautii",
"s__Haemophilus_parainfluenzae",
"s__Odoribacter_splanchnicus",
"s__Streptococcus_salivarius",
"s__Veillonella_parvula")
top10_sp=subset(sp_N50_h1,sp %in% select_sp)
order_sp=as.character(unique(top10_sp[order(top10_sp$N50,decreasing = T),"sp"]))
p2<-ggplot(top10_sp,aes(x=sp,y=N50,col=method,shape=method))+geom_point()+coord_flip()+xlim(rev(order_sp))
p2

library(ggpubr)
pp <- ggarrange(p1, p2, ncol=1, nrow=2,
                labels=c("a. Human Sample 1", "b. Mouse Sample 1"),
                common.legend=TRUE, align="hv", heights=c(1,1),
                legend="right")
pp
