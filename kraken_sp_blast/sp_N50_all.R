library(ggplot2)
# for human 1
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
p1<-ggplot(top10_sp,aes(x=sp,y=N50))+geom_point(aes(col=method,shape=method))+
    labs(title="", x="", y="N50", shape="", col="") +
    coord_flip()+xlim(rev(order_sp))

# human 2
sp_N50_h1_athena<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\human_2_athena.sp_N50",header=F)

colnames(sp_N50_h1_athena)=c("species","contig_count","length_sum","N50")
sp_N50_h1_athena$method="stLFR_Athena"

sp_N50_h1_st_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\H2_spa.sp_N50",header=F)
colnames(sp_N50_h1_st_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_st_spa$method="stLFR_SPAdes"

sp_N50_h1_wgs_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\H2wgs_spa.sp_N50",header=F)
colnames(sp_N50_h1_wgs_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_wgs_spa$method="WGS_SPAdes"

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
"s__Veillonella_parvula"
)

#select_sp=c("s__Alistipes_finegoldii",
#"s__Anaerostipes_hadrus",
#"s__Bacteroides_fragilis",
#"s__Bacteroides_ovatus",
#"s__Bacteroides_thetaiotaomicron",
#"s__Bacteroides_vulgatus",
#"s__Bifidobacterium_adolescentis",
#"s__Bifidobacterium_longum",
#"s__Bifidobacterium_pseudocatenulatum",
#"s__Escherichia_coli",
#"s__[Eubacterium]_eligens",
#"s__[Eubacterium]_rectale",
#"s__Flavonifractor_plautii",
#"s__Haemophilus_parainfluenzae",
#"s__Odoribacter_splanchnicus",
#"s__Streptococcus_salivarius",
#"s__Veillonella_parvula"
#)

top10_sp=subset(sp_N50_h1,sp %in% select_sp)
top10_sp$sp=gsub("s__", "", top10_sp$sp)
top10_sp$sp=gsub("_", " ", top10_sp$sp)
order_sp=as.character(unique(top10_sp[order(top10_sp$N50,decreasing = T),"sp"]))
p2<-ggplot(top10_sp,aes(x=sp,y=N50))+geom_point(aes(col=method,shape=method))+
    labs(title="", x="", y="N50", shape="", col="") +
    coord_flip()+xlim(rev(order_sp))

# human 3
sp_N50_h1_athena<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\human_3_add_athena.sp_N50",header=F)

colnames(sp_N50_h1_athena)=c("species","contig_count","length_sum","N50")
sp_N50_h1_athena$method="stLFR_Athena"

sp_N50_h1_st_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\H3_spa.sp_N50",header=F)
colnames(sp_N50_h1_st_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_st_spa$method="stLFR_SPAdes"

sp_N50_h1_wgs_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\H3wgs_spa.sp_N50",header=F)
colnames(sp_N50_h1_wgs_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_wgs_spa$method="WGS_SPAdes"

sp_N50_h1=rbind(sp_N50_h1_athena,sp_N50_h1_st_spa,sp_N50_h1_wgs_spa)
sp_N50_h1$sp=apply(sp_N50_h1,1,function(a){
  b=strsplit(as.character(a["species"]),split="|",fixed=T)[[1]];
  b[length(b)]})
sp_N50_h1$sp <- as.character(sp_N50_h1$sp)

select_sp=c("s__Anaerostipes_hadrus",
"s__Bacteroides_cellulosilyticus",
"s__Bacteroides_dorei",
"s__Bacteroides_ovatus",
"s__Bacteroides_thetaiotaomicron",
"s__[Eubacterium]_eligens",
"s__Odoribacter_splanchnicus",
"s__Roseburia_hominis",
"s__Ruminococcus_bicirculans"
)

#select_sp=c("s__Alistipes_finegoldii",
#"s__Anaerostipes_hadrus",
#"s__Bacteroides_cellulosilyticus",
#"s__Bacteroides_dorei",
#"s__Bacteroides_fragilis",
#"s__Bacteroides_ovatus",
#"s__Bacteroides_thetaiotaomicron",
#"s__Bacteroides_vulgatus",
#"s__[Eubacterium]_eligens",
#"s__[Eubacterium]_rectale",
#"s__Haemophilus_parainfluenzae",
#"s__Odoribacter_splanchnicus",
#"s__Roseburia_hominis",
#"s__Ruminococcus_bicirculans"
#)

top10_sp=subset(sp_N50_h1,sp %in% select_sp)
top10_sp$sp=gsub("s__", "", top10_sp$sp)
top10_sp$sp=gsub("_", " ", top10_sp$sp)
order_sp=as.character(unique(top10_sp[order(top10_sp$N50,decreasing = T),"sp"]))
p3<-ggplot(top10_sp,aes(x=sp,y=N50))+geom_point(aes(col=method,shape=method))+
    labs(title="", x="", y="N50", shape="", col="") +
    coord_flip()+xlim(rev(order_sp))

# for mouse 1
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

# for mouse 2
sp_N50_h1_athena<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\mouse_2_athena.sp_N50",header=F)
colnames(sp_N50_h1_athena)=c("species","contig_count","length_sum","N50")
sp_N50_h1_athena$method="stLFR_Athena"

sp_N50_h1_st_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\M2_spa.sp_N50",header=F)
colnames(sp_N50_h1_st_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_st_spa$method="stLFR_SPADE"

sp_N50_h1_wgs_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\M2wgs_spa.sp_N50",header=F)
colnames(sp_N50_h1_wgs_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_wgs_spa$method="WGS_SPADE"

sp_N50_h1=rbind(sp_N50_h1_athena,sp_N50_h1_st_spa,sp_N50_h1_wgs_spa)
sp_N50_h1$sp=apply(sp_N50_h1,1,function(a){
  b=strsplit(as.character(a["species"]),split="|",fixed=T)[[1]];
  b[length(b)]})
sp_N50_h1$sp <- as.character(sp_N50_h1$sp)

select_sp=c("s__Akkermansia_muciniphila",
"s__Bifidobacterium_pseudolongum",
"s__Helicobacter_bilis"
)

select_sp=c("s__Akkermansia_muciniphila",
"s__Bifidobacterium_pseudolongum",
"s__Helicobacter_bilis"
)
top10_sp=subset(sp_N50_h1,sp %in% select_sp)
top10_sp$sp=gsub("s__", "", top10_sp$sp)
top10_sp$sp=gsub("_", " ", top10_sp$sp)
order_sp=as.character(unique(top10_sp[order(top10_sp$N50,decreasing = T),"sp"]))
p5<-ggplot(top10_sp,aes(x=sp,y=N50))+geom_point(aes(col=method,shape=method))+
    labs(title="", x="", y="N50", shape="", col="") +
    coord_flip()+xlim(rev(order_sp))

# for mouse 1
sp_N50_h1_athena<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\mouse_3_athena.sp_N50",header=F)
colnames(sp_N50_h1_athena)=c("species","contig_count","length_sum","N50")
sp_N50_h1_athena$method="stLFR_Athena"

sp_N50_h1_st_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\M3_spa.sp_N50",header=F)
colnames(sp_N50_h1_st_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_st_spa$method="stLFR_SPADE"

sp_N50_h1_wgs_spa<-read.delim("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\kraken_sp_blast\\kraken_sp_blast\\M3wgs_spa.sp_N50",header=F)
colnames(sp_N50_h1_wgs_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_wgs_spa$method="WGS_SPADE"

sp_N50_h1=rbind(sp_N50_h1_athena,sp_N50_h1_st_spa,sp_N50_h1_wgs_spa)
sp_N50_h1$sp=apply(sp_N50_h1,1,function(a){
  b=strsplit(as.character(a["species"]),split="|",fixed=T)[[1]];
  b[length(b)]})
sp_N50_h1$sp <- as.character(sp_N50_h1$sp)

select_sp=c("s__Akkermansia_muciniphila",
"s__Bifidobacterium_pseudolongum",
"s__Enterococcus_faecalis",
"s__Helicobacter_bilis",
"s__Lactobacillus_johnsonii",
"s__Proteus_mirabilis"
)

top10_sp=subset(sp_N50_h1,sp %in% select_sp)
top10_sp$sp=gsub("s__", "", top10_sp$sp)
top10_sp$sp=gsub("_", " ", top10_sp$sp)
order_sp=as.character(unique(top10_sp[order(top10_sp$N50,decreasing = T),"sp"]))
p6<-ggplot(top10_sp,aes(x=sp,y=N50))+geom_point(aes(col=method,shape=method))+
    labs(title="", x="", y="N50", shape="", col="") +
    coord_flip()+xlim(rev(order_sp))

library(ggpubr)
pp<-ggarrange(p1, p2, p3, p4, p5, p6, nrow=2, ncol=3,
              labels=c("H1", "H2", "H3", "M1", "M2", "M3"),
              common.legend=TRUE, widths=c(1,1,1, 1, 1, 1),
              legend="top")
pp

