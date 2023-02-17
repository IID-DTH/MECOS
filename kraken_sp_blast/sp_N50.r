library(ggplot2)
sp_N50_h1_athena<-read.delim("Human_meta_1_athena.sp_N50",header=F)
colnames(sp_N50_h1_athena)=c("species","contig_count","length_sum","N50")
sp_N50_h1_athena$method="stLFR_athena"
sp_N50_h1_athena$sp=apply(sp_N50_h1_athena,1,function(a){
  b=strsplit(as.character(a["species"]),split="|",fixed=T)[[1]];
  b[length(b)]})

sp_N50_h1_st_spa<-read.delim("H1_spa.sp_N50",header=F)
colnames(sp_N50_h1_st_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_st_spa$method="stLFR_SPADE"

sp_N50_h1_wgs_spa<-read.delim("H1wgs_spa.spN50",header=F)
colnames(sp_N50_h1_wgs_spa)=c("species","contig_count","length_sum","N50")
sp_N50_h1_wgs_spa$method="WGS_SPADE"

sp_N50_h1=rbind(sp_N50_h1_athena,sp_N50_h1_st_spa,sp_N50_h1_wgs_spa)
sp_N50_h1$sp=apply(sp_N50_h1,1,function(a){
  b=strsplit(as.character(a["species"]),split="|",fixed=T)[[1]];
  b[length(b)]})


sp_len_all=tapply(sp_N50_h1$length_sum,sp_N50_h1$species,sum)
top10_sp=subset(sp_N50_h1,species %in% names(head(sp_len_all[order(sp_len_all,decreasing = T)],10)))
order_sp=as.character(unique(top10_sp[order(top10_sp$N50,decreasing = T),"sp"]))

order_sp=head(as.character(sp_N50_h1_athena[order(sp_N50_h1_athena$N50,decreasing = T),]$sp),10)
top10_sp=subset(sp_N50_h1,sp %in% order_sp)
ggplot(top10_sp,aes(x=sp,y=N50,col=method))+geom_point()+xlim(rev(order_sp))+coord_flip()

select_sp=c("s__Escherichia_coli","s__Bifidobacterium_longum","s__Bacteroides_vulgatus","s__Bifidobacterium_adolescentis", "s__Bacteroides_caccae","s__Roseburia_hominis", "s__Bacteroides_cellulosilyticus", "s__Bacteroides_ovatus", "s__Ruminococcus_bicirculans")
top10_sp=subset(sp_N50_h1,sp %in% select_sp)
order_sp=as.character(unique(top10_sp[order(top10_sp$N50,decreasing = T),"sp"]))
ggplot(top10_sp,aes(x=sp,y=N50,col=method))+geom_point()+coord_flip()+xlim(rev(order_sp))+theme_classic()