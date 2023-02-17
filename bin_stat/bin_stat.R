library(ggplot2)
library(ggpubr)

data_fp <- read.table("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\bin_stat\\human_1_stat_all.log", sep='\t', head=F)
colnames(data_fp) <- c('method', 'val')
df <- data.frame(method=data_fp$method, val=data_fp$val)

p1<-ggplot(df, aes(x=val, fill=method, color=method)) +
   geom_histogram(alpha=0.2, position="stack",bins=50) + xlim(NA,1) + labs(x='ratio')

data_fp <- read.table("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\bin_stat\\human_2_stat_all.log", sep='\t', head=F)
colnames(data_fp) <- c('method', 'val')
df <- data.frame(method=data_fp$method, val=data_fp$val)

p2<-ggplot(df, aes(x=val, fill=method, color=method)) +
   geom_histogram(alpha=0.2, position="stack",bins=50) + xlim(NA,1) + labs(x='ratio')

data_fp <- read.table("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\bin_stat\\human_3_stat_all.log", sep='\t', head=F)
colnames(data_fp) <- c('method', 'val')
df <- data.frame(method=data_fp$method, val=data_fp$val)

p3<-ggplot(df, aes(x=val, fill=method, color=method)) +
   geom_histogram(alpha=0.2, position="stack",bins=50) + xlim(NA,1) + labs(x='ratio')

data_fp <- read.table("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\bin_stat\\mouse_1_stat_all.log", sep='\t', head=F)
colnames(data_fp) <- c('method', 'val')
df <- data.frame(method=data_fp$method, val=data_fp$val)

p4<-ggplot(df, aes(x=val, fill=method, color=method)) +
   geom_histogram(alpha=0.2, position="stack",bins=50) + xlim(NA,1) + labs(x='ratio')

data_fp <- read.table("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\bin_stat\\mouse_2_stat_all.log", sep='\t', head=F)
colnames(data_fp) <- c('method', 'val')
df <- data.frame(method=data_fp$method, val=data_fp$val)

p5<-ggplot(df, aes(x=val, fill=method, color=method)) +
   geom_histogram(alpha=0.2, position="stack",bins=50) + xlim(NA,1) + labs(x='ratio')

data_fp <- read.table("C:\\Users\\spikeliu\\Documents\\jobs\\study\\meta\\bin_stat\\mouse_3_stat_all.log", sep='\t', head=F)
colnames(data_fp) <- c('method', 'val')
df <- data.frame(method=data_fp$method, val=data_fp$val)

p6<-ggplot(df, aes(x=val, fill=method, color=method)) +
   geom_histogram(alpha=0.2, position="stack",bins=50) + xlim(NA,1) + labs(x='ratio')

pp<-ggarrange(p1, p2, p3, p4, p5, p6, nrow=2, ncol=3, label.x=0.5,
              labels=c("H1", "H2", "H3", "M1", "M2", "M3"), 
              common.legend=T,
              align="hv", legend="right")

pp
