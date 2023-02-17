library(circlize)
#pdf('hgt_link.pdf')
len_fp <- read.table("data\\Human_meta_1_athena.len", sep='\t', head=F)
colnames(len_fp) <- c('name', 'stop')
len_fp$start=0
bed_1_fp <- read.table("data\\Human_meta_1_athena.link.1.bed", sep='\t', head=T)
bed_2_fp <- read.table("data\\Human_meta_1_athena.link.2.bed", sep='\t', head=T)


indices<-sample(nrow(bed_1_fp), 10)
bed_1_fp<- bed_1_fp[indices,]
bed_2_fp<- bed_2_fp[indices,]
len_fp<-subset(len_fp,name %in% rbind(bed_1_fp, bed_2_fp)$idx)
df <- data.frame(name=len_fp$name,
                 start=len_fp$start,
                 stop=len_fp$stop)
#df <- df[sample(nrow(df), 20),]
circos.genomicInitialize(df,plotType=c("axis"))
#circos.genomicInitialize(df)
circos.track(track.index = 1, panel.fun = function(x, y) {
    circos.text(CELL_META$xcenter, CELL_META$ylim[1], rep('a', nrow(df)), 
        facing = "clockwise", niceFacing = TRUE, adj=c(-2,0.5))
}, bg.border = NA) # here set bg.border to NA is important
circos.track(ylim = c(0, 1), 
    bg.col = rand_color(nrow(df), hue="monochrome"), 
    bg.border = NA, track.height = 0.05)
circos.genomicLink(bed_1_fp, bed_2_fp, col = rand_color(nrow(bed_1_fp), transparency = 0), 
    border = NA)
circos.clear()
#dev.off()