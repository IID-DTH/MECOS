library(ggplot2)
min_length <- 1000
human1_ctg_len <- read.table('C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\contig_length\\Human_1_contigs.length')
#head(human1_ctg_len)

df <- data.frame(method=human1_ctg_len$V1,
                 length=human1_ctg_len$V2,
                 rank=human1_ctg_len$V3)
df<-df[df$length>=min_length,]
#head(df)



p1<-ggplot(df, aes(x=log10(rank), y=length, group=method)) +
          geom_line(aes(color=method)) + 
          theme_minimal() +
          theme(legend.position="top") + #plot.margin = unit(c(1,1,1,1),"cm")
          ggtitle(label="a. Human Sample 1")
          #scale_x_continuous(name="rank")
#p1
human2_ctg_len <- read.table('C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\contig_length\\Human_2_contigs.length')

df <- data.frame(method=human2_ctg_len$V1,
                 length=human2_ctg_len$V2,
                 rank=human2_ctg_len$V3)
df<-df[df$length>=min_length,]
p2<-ggplot(df, aes(x=log10(rank), y=length, group=method)) +
          geom_line(aes(color=method)) + 
          theme_minimal() +
          theme(legend.position="top") +
          ggtitle(label="b. Human Sample 2")
          #scale_x_continuous(name="rank")

human3_ctg_len <- read.table('C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\contig_length\\Human_3_contigs.length')

df <- data.frame(method=human3_ctg_len$V1,
                 length=human3_ctg_len$V2,
                 rank=human3_ctg_len$V3)
df<-df[df$length>=min_length,]
p3<-ggplot(df, aes(x=log10(rank), y=length, group=method)) +
          geom_line(aes(color=method)) + 
          theme_minimal() +
          theme(legend.position="top") +
          ggtitle(label="c. Human Sample 3")
          #scale_x_continuous(name="rank")

mice1_ctg_len <- read.table('C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\contig_length\\Mice_1_contigs.length')

df <- data.frame(method=mice1_ctg_len$V1,
                 length=mice1_ctg_len$V2,
                 rank=mice1_ctg_len$V3)
df<-df[df$length>=min_length,]
p4<-ggplot(df, aes(x=log10(rank), y=length, group=method)) +
          geom_line(aes(color=method)) + 
          theme_minimal() +
          theme(legend.position="top") +
          ggtitle(label="d. Mouse Sample 1")
          #scale_x_continuous(name="rank")

mice2_ctg_len <- read.table('C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\contig_length\\Mice_2_contigs.length')

df <- data.frame(method=mice2_ctg_len$V1,
                 length=mice2_ctg_len$V2,
                 rank=mice2_ctg_len$V3)
df<-df[df$length>=min_length,]
p5<-ggplot(df, aes(x=log10(rank), y=length, group=method)) +
          geom_line(aes(color=method)) + 
          theme_minimal() +
          theme(legend.position="top") +
          ggtitle(label="e. Mouse Sample 2")
          #scale_x_continuous(name="rank")

mice3_ctg_len <- read.table('C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\contig_length\\Mice_3_contigs.length')

df <- data.frame(method=mice3_ctg_len$V1,
                 length=mice3_ctg_len$V2,
                 rank=mice3_ctg_len$V3)
df<-df[df$length>=min_length,]
p6<-ggplot(df, aes(x=log10(rank), y=length, group=method)) +
          geom_line(aes(color=method)) + 
          theme_minimal() +
          theme(legend.position="top") +
          ggtitle(label="f. Mouse Sample 3")
          #scale_x_continuous(name="rank")

library(ggpubr)

pp <- ggarrange(p1, p2, p3, p4, p5, p6, ncol=3, nrow=2,
              common.legend=TRUE,
              legend="top")

pp