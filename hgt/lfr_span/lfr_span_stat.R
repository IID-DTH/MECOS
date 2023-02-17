library(ggplot2)
library(gggenes)
data_set <- read.table("res.lfr_span", sep='\t', head=T)

df <- data.frame(barcode=data_set$barcode,
                 x_start=as.numeric(data_set$x_start),
                 x_end=as.numeric(data_set$x_end),
                 y_start=as.numeric(data_set$y_start),
                 y_end=as.numeric(data_set$y_end),
                 size=as.numeric(data_set$size)
                 )
#df <- data.frame(data_set)
p1 <- ggplot()# + xlim(x, 24433)

p1 <- p1 + geom_segment(data=df, 
      mapping=aes(x=x_start, y=y_start, xend=x_end, yend=y_end, color=barcode),
      size=df$size, show.legend=FALSE) + 
      scale_color_gradientn(colours = rainbow(259)) +
      theme(axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.y=element_blank(),
        axis.line.x = element_line(size=1, arrow=arrow(length=unit(0.1, 'inches')))) + 
        labs(x='contig length')

data_set <- read.table("res.gene_span",  sep='\t', head=T)
df <- data.frame(gene=data_set$gene,
                 start=as.numeric(data_set$start),
                 end=as.numeric(data_set$end)
                 )
p1 <- p1 + geom_gene_arrow(data=df,
      mapping=aes(xmin=start, xmax=end, y=-5, fill = gene)
      )


p1