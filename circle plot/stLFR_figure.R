library(ggplot2)

H1_2138_R_bici<-read.delim("s__Ruminococcus_bicirculans.m8",header = F)
colnames(H1_2138_R_bici)=c("contig","chr","identity","length","mismatch","gap","contig_s","contig_e","chr_s","chr_e")
H1_2138_R_bici$no=1:nrow(H1_2138_R_bici)

to_plot_H1_2138_R_bici=subset(H1_2138_R_bici,chr=="HF545616.1"&length>1000)[,c("contig","chr","contig_s","chr_s","no")]
colnames(to_plot_H1_2138_R_bici)[3:4]=c("p_contig","p_chr")
to_plot_H1_2138_R_bici2=subset(H1_2138_R_bici,chr=="HF545616.1"&length>1000)[,c("contig","chr","contig_e","chr_e","no")]
colnames(to_plot_H1_2138_R_bici2)[3:4]=c("p_contig","p_chr")
to_plot_H1_2138_R_bici=rbind(to_plot_H1_2138_R_bici,to_plot_H1_2138_R_bici2)
ggplot(to_plot_H1_2138_R_bici,aes(x=p_chr,y=p_contig))+geom_line(aes(group=no,col=contig))+theme_classic()

to_plot_H1_2138_R_bici$p_chr2=to_plot_H1_2138_R_bici$p_chr
to_plot_H1_2138_R_bici[to_plot_H1_2138_R_bici$p_chr2>702136,"p_chr2"]=to_plot_H1_2138_R_bici[to_plot_H1_2138_R_bici$p_chr2>702136,]$p_chr- 2239423

to_plot_H1_2138_R_bici$p_contig2=to_plot_H1_2138_R_bici$p_contig
to_plot_H1_2138_R_bici[to_plot_H1_2138_R_bici$contig=="gnl|X|Human_meta_1_athena_6321","p_contig2"]=-to_plot_H1_2138_R_bici[to_plot_H1_2138_R_bici$contig=="gnl|X|Human_meta_1_athena_6321",]$p_contig
+max(subset(to_plot_H1_2138_R_bici,contig=="gnl|X|Human_meta_1_athena_7909")$p_contig) 
-min(-subset(to_plot_H1_2138_R_bici,contig=="gnl|X|Human_meta_1_athena_6321")$p_contig)

to_plot_H1_2138_R_bici[to_plot_H1_2138_R_bici$contig=="gnl|X|Human_meta_1_athena_2138","p_contig2"]=to_plot_H1_2138_R_bici[to_plot_H1_2138_R_bici$contig=="gnl|X|Human_meta_1_athena_2138",]$p_contig+415536+422123

to_plot_H1_2138_R_bici=subset(to_plot_H1_2138_R_bici,contig %in% c("gnl|X|Human_meta_1_athena_7909","gnl|X|Human_meta_1_athena_6321","gnl|X|Human_meta_1_athena_2138"))


ggplot(to_plot_H1_2138_R_bici,aes(x=p_chr2,y=p_contig2))+geom_line(aes(group=no,col=contig))+theme_classic()

ggplot(subset(to_plot_H1_2138_R_bici,contig %in% c("gnl|X|Human_meta_1_athena_2138","gnl|X|Human_meta_1_athena_7909","gnl|X|Human_meta_1_athena_6321")),aes(x=p_chr,y=p_contig))+geom_line(aes(group=no,col=contig))+theme_classic()+theme_classic()


ggplot((subset(H1_2138_R_bici,contig %in% c("gnl|X|Human_meta_1_athena_2138","gnl|X|Human_meta_1_athena_7909","gnl|X|Human_meta_1_athena_6321"))))+geom_rect(aes(ymin=4,ymax=5,xmin=chr_s,xmax=chr_e,fill=contig))+coord_polar()+ylim(0,5)
ggplot(to_plot_H1_R_bici_solar,aes(x=p_chr,y=p_contig))+geom_line(aes(group=no,col=Qname))+theme_classic()+facet_wrap(~Sname,scale="free")

