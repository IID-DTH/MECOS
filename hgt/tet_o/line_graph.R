library(ggplot2)

data_fp <- read.table("tet_O.m8", sep='\t', head=F)
colnames(data_fp) <- c('qaccver',
                       'saccver', 
                        'pident',
                        'length', 
                      'mismatch', 
                       'gapopen', 
                        'qstart',
                          'qend',
                        'sstart',
                          'send',
                        'evalue',
                      'bitscore')
data_sub <- data_fp[which(data_fp$qaccver=='gnl|X|human_3_athena_1325' & 
                          data_fp$saccver=='gnl|X|human_3_pacbio_639'),]
df <- data.frame(x=c(data_sub$qstart, data_sub$qend), y=c(data_sub$sstart, data_sub$send))

df <- df[1:3,]
p1<-ggplot(df) + geom_line(aes(x=x[2:3], y=y[2:3]), color='red') #+ 
           #geom_line(aes(x=x[2:3], y=y[2:3]),color='green')
p1