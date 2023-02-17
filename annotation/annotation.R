library(reshape2)
library(ggplot2)

data<-read.table("data\\hgt_annotation_partial", sep='\t', head=T)
data.m<-melt(data)
colnames(data.m)<-c('annotation', 'method', 'count') 
#data.m$count<-rescale(data.m$count)
p <- ggplot(data.m, aes(method, annotation)) + 
     geom_tile(aes(fill = count), color='black') + 
     scale_fill_gradient(low="white", high="steelblue") +
     labs(x='sample & method', y='annotation (product)') +
     theme(axis.text.x = element_text(angle = 330, hjust=0))
p