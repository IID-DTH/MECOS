library(ggplot2)
library(gggenes)
data_set <- read.table("res_1325.tgs_span", sep='\t', head=T)

df_tgs <- data.frame(rid=data_set$rid,
                 x_start=as.numeric(data_set$x_start),
                 x_end=as.numeric(data_set$x_end),
                 y_start=as.numeric(data_set$y_start),
                 y_end=as.numeric(data_set$y_end),
                 size=as.numeric(data_set$size)
                 )



p1 <- ggplot()# + xlim(x, 24433)

p1 <- p1 + 
      geom_segment(data=df_tgs, 
      mapping=aes(x=x_start, y=y_start, xend=x_end, yend=y_end), color='black',
      size=df_tgs$size, show.legend=FALSE) + 
      
      theme(panel.background=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.y=element_blank(),
        axis.line.x = element_line(size=1, arrow=arrow(length=unit(0.1, 'inches')))) + 
        labs(x='contig length')

data_set <- read.table("res_1325.gene_span",  sep='\t', head=T)
df <- data.frame(gene=data_set$gene,
                 start=as.numeric(data_set$start),
                 end=as.numeric(data_set$end),
                 color=data_set$color
                 )
p1 <- p1 + geom_gene_arrow(data=df,
      mapping=aes(xmin=start, xmax=end, y=-2, fill=color)
      ) + scale_fill_manual(name='gene', values=c("#00AFBB", '#FC4E07'))


p1