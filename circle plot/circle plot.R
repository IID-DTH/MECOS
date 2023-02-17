library(circlize)
ctg_align <- read.table("results.out")
colnames(ctg_align)=c("contig",
                           "chr",
                           "identity",
                           "length",
                           "mismatch",
                           "gap",
                           "contig_s",
                           "contig_e",
                           "chr_s",
                           "chr_e")

ctg_align = subset(ctg_align, 1 & 
                             (contig == "contig_121" | 
                              contig == "contig_491" | 
                              contig == "contig_339"))
#c("#F8766D", "#619CFF", "#00BA38")
color <- vector()
for (c in ctg_align$contig){
    if (c == "contig_121") {
        color <- c(color, "#F8766D")
    }
    if (c == "contig_491") {
        color <- c(color, "#619CFF")
    }
    if (c == "contig_339") {
        
        color <- c(color, "#00BA38")
	}
}

df <- data.frame(contig=ctg_align$contig,
                 chr=ctg_align$chr,
                 chr_s=ctg_align$chr_s,
                 chr_e=ctg_align$chr_e,
                 color=color)
circos.par(gap.degree=0,
           #cell.padding=c(0, 1.00, 0, 1.00),
           unit.circle.segments=5000)
circos.initialize(fa= df$chr, xlim = c(0, 2240877))

circos.track(fa=df$chr, ylim = c(0, 1), panel.fun = function(x, y) {
        circos.rect(df$chr_s, 0, df$chr_e, 1, col=df$color, 
                    density=NA, border=FALSE)
        #circos.axis(major.at=c(0, 500000, 1000000, 1500000, 2000000, 2200000), 
        #            labels = c("0", "0.5M", "1M", "1.5M", "2M", "2.2M"), col=NA)
        circos.axis(major.at=c(700000, 1200000, 1700000, 2200000, 459123), 
                    labels = c("0 M", "0.5 M", "1 M", "1.5 M", "2 M"), col=NA)

},
            track.height = 0.2,
            #cell.padding=c(0, 1.00, 0, 1.00),
            bg.border=NA)
read_cov <- read.table("ruminococcus_bicirculans_partial_binsize_1000.cov")
colnames(read_cov)=c("ref", "pos", "depth")

#read_cov <- subset(read_cov, pos < 1000)
read_cov$depth[read_cov$depth>=500]<-500
df <- data.frame(ref=read_cov$ref, pos=read_cov$pos, depth=read_cov$depth)

circos.track(fa=df$ref, x=df$pos, y=df$depth, ylim = c(0, 600),
             track.height = 0.2,
             panel.fun = function(x,y) {
        circos.lines(df$pos, df$depth, type="l", col = "purple")
        circos.yaxis(at=c(250, 500),
                     labels = c("250", "500"),
                     labels.cex = 0.65)        
},
        
)


text(0, 0, "Ruminococcus bicirculans\n genome chr1")
legend("bottomright", bty="n", pch = NA, fill = c("#F8766D", "#619CFF", "#00BA38"), 
        legend = c("contig_2138", "contig_7909", "contig_6321"), border=NA, merge=FALSE )
circos.info()
circos.clear()


a<-df

for (i in 1:nrow(df)) {
    s<-a[i,3]
    e<-a[i,4]
    if (s > e) {
        a[i,3] <- e
        a[i,4] <- s
    }
}

a<-a[order(a$chr_s),]

start<-0
end<-0
total_length<-0
for (i in 1:nrow(a)) {
    s<-a[i,3]
    e<-a[i,4]
    if (s > end) {
        total_length = total_length + (end-start)
        start <- s
        end <- e
    }
    else {
        if (end < e) {
            end<-e
        }
    }
}
total_length = total_length + (end-start)

