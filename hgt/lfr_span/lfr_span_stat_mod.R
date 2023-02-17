library(ggplot2)
library(gggenes)
data_set <- read.table("res.lfr_span", sep='\t', head=T)

df_lfr <- data.frame(barcode=data_set$barcode,
                 x_start=as.numeric(data_set$x_start),
                 x_end=as.numeric(data_set$x_end),
                 y_start=as.numeric(data_set$y_start),
                 y_end=as.numeric(data_set$y_end),
                 #size=as.numeric(data_set$size)
                 size=as.numeric(rep(0.1, length(data_set$size)))
                 )

data_set <- read.table("res.read_span", sep='\t', head=T)
df_read <- data.frame(barcode=data_set$barcode,
                 x_start=as.numeric(data_set$x_start),
                 x_end=as.numeric(data_set$x_end),
                 y_start=as.numeric(data_set$y_start),
                 y_end=as.numeric(data_set$y_end),
                 #size=as.numeric(data_set$size)
                 size=as.numeric(rep(0.5, length(data_set$size)))
                 )

p1 <- ggplot()# + xlim(x, 24433)

p1 <- p1 + 
      geom_segment(data=df_lfr, 
      mapping=aes(x=x_start, y=y_start, xend=x_end, yend=y_end), color='black',
      size=df_lfr$size, show.legend=FALSE) + 
      geom_segment(data=df_read, 
      mapping=aes(x=x_start, y=y_start, xend=x_end, yend=y_end, color=barcode),
      size=df_read$size, show.legend=FALSE) + 
      scale_color_gradientn(colors=rainbow(length(unique(df_read$barcode)))) +
      theme(panel.background=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.y=element_blank(),
        axis.line.x = element_line(size=1, arrow=arrow(length=unit(0.1, 'inches')))) + 
        labs(x='contig length')

data_set <- read.table("res.gene_span",  sep='\t', head=T)
df <- data.frame(gene=data_set$gene,
                 start=as.numeric(data_set$start),
                 end=as.numeric(data_set$end),
                 color=data_set$color
                 )
p1 <- p1 + geom_gene_arrow(data=df,
      mapping=aes(xmin=start, xmax=end, y=-20, fill=color)
      ) + scale_fill_manual(name='gene', values=c("#00AFBB", '#FC4E07')) 
p1