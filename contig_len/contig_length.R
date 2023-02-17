library(ggplot2)

ctg_len <- read.delim('Human_meta_1_spades_contigs.len', head=F)
wgs_len <- ctg_len$V2 
ctg_len <- read.delim('Human_meta_1_stLFR_spades_contigs.len', head=F)
spades_len <- ctg_len$V2

ctg_len <- read.delim('Human_meta_1_athena.len', head=F)
athena_len <- ctg_len$V2
method <- c(rep("WGS_metaSPAdes", length(wgs_len)),
                 rep("stLFR_metaSPAdes", length(spades_len)),
                 rep("stLFR_Athena", length(athena_len)))
rank <- c(rank(-wgs_len), rank(-spades_len), rank(-athena_len))
len <- c(wgs_len, spades_len, athena_len)

#head(human1_ctg_len)

df <- data.frame(method=method,
                 length=len,
                 rank=rank)
#head(df)
df<-df[df$length>=1000,]
p1<-ggplot(df, aes(x=log10(rank), y=length, group=method)) +
          geom_line(aes(color=method)) + 
          theme_minimal() +
          theme(legend.position="top") +
          ggtitle(label="a. Human Sample 1")
          #scale_x_continuous(name="rank")

ctg_len <- read.delim('Human_meta_2_spades_contigs.len', head=F)
wgs_len <- ctg_len$V2 
ctg_len <- read.delim('Human_meta_2_stLFR_spades_contigs.len', head=F)
spades_len <- ctg_len$V2

ctg_len <- read.delim('Human_meta_2_athena.len', head=F)
athena_len <- ctg_len$V2
method <- c(rep("WGS_metaSPAdes", length(wgs_len)),
                 rep("stLFR_metaSPAdes", length(spades_len)),
                 rep("stLFR_Athena", length(athena_len)))
rank <- c(rank(-wgs_len), rank(-spades_len), rank(-athena_len))
len <- c(wgs_len, spades_len, athena_len)

#head(human1_ctg_len)

df <- data.frame(method=method,
                 length=len,
                 rank=rank)
#head(df)
df<-df[df$length>=1000,]
p2<-ggplot(df, aes(x=log10(rank), y=length, group=method)) +
          geom_line(aes(color=method)) + 
          theme_minimal() +
          theme(legend.position="top") +
          ggtitle(label="b. Human Sample 2")
          #scale_x_continuous(name="rank")

ctg_len <- read.delim('Human_meta_3_spades_contigs.len', head=F)
wgs_len <- ctg_len$V2 
ctg_len <- read.delim('Human_meta_3_stLFR_spades_contigs.len', head=F)
spades_len <- ctg_len$V2

ctg_len <- read.delim('Human_meta_3_athena.len', head=F)
athena_len <- ctg_len$V2
method <- c(rep("WGS_metaSPAdes", length(wgs_len)),
                 rep("stLFR_metaSPAdes", length(spades_len)),
                 rep("stLFR_Athena", length(athena_len)))
rank <- c(rank(-wgs_len), rank(-spades_len), rank(-athena_len))
len <- c(wgs_len, spades_len, athena_len)

#head(human1_ctg_len)

df <- data.frame(method=method,
                 length=len,
                 rank=rank)
#head(df)
df<-df[df$length>=1000,]
p3<-ggplot(df, aes(x=log10(rank), y=length, group=method)) +
          geom_line(aes(color=method)) + 
          theme_minimal() +
          theme(legend.position="top") +
          ggtitle(label="c. Human Sample 3")
          #scale_x_continuous(name="rank")

ctg_len <- read.delim('Mice_meta_1_spades_contigs.len', head=F)
wgs_len <- ctg_len$V2 
ctg_len <- read.delim('Mice_meta_1_stLFR_spades_contigs.len', head=F)
spades_len <- ctg_len$V2

ctg_len <- read.delim('Mice_meta_1_athena.len', head=F)
athena_len <- ctg_len$V2
method <- c(rep("WGS_metaSPAdes", length(wgs_len)),
                 rep("stLFR_metaSPAdes", length(spades_len)),
                 rep("stLFR_Athena", length(athena_len)))
rank <- c(rank(-wgs_len), rank(-spades_len), rank(-athena_len))
len <- c(wgs_len, spades_len, athena_len)

#head(human1_ctg_len)

df <- data.frame(method=method,
                 length=len,
                 rank=rank)
#head(df)
df<-df[df$length>=1000,]
p4<-ggplot(df, aes(x=log10(rank), y=length, group=method)) +
          geom_line(aes(color=method)) + 
          theme_minimal() +
          theme(legend.position="top") +
          ggtitle(label="d. Mice Sample 1")
          #scale_x_continuous(name="rank")

ctg_len <- read.delim('Mice_meta_2_spades_contigs.len', head=F)
wgs_len <- ctg_len$V2 
ctg_len <- read.delim('Mice_meta_2_stLFR_spades_contigs.len', head=F)
spades_len <- ctg_len$V2

ctg_len <- read.delim('Mice_meta_2_athena.len', head=F)
athena_len <- ctg_len$V2
method <- c(rep("WGS_metaSPAdes", length(wgs_len)),
                 rep("stLFR_metaSPAdes", length(spades_len)),
                 rep("stLFR_Athena", length(athena_len)))
rank <- c(rank(-wgs_len), rank(-spades_len), rank(-athena_len))
len <- c(wgs_len, spades_len, athena_len)

#head(human1_ctg_len)

df <- data.frame(method=method,
                 length=len,
                 rank=rank)
#head(df)
df<-df[df$length>=1000,]
p5<-ggplot(df, aes(x=log10(rank), y=length, group=method)) +
          geom_line(aes(color=method)) + 
          theme_minimal() +
          theme(legend.position="top") +
          ggtitle(label="e. Mice Sample 2")
          #scale_x_continuous(name="rank")

ctg_len <- read.delim('Mice_meta_3_spades_contigs.len', head=F)
wgs_len <- ctg_len$V2 
ctg_len <- read.delim('Mice_meta_3_stLFR_spades_contigs.len', head=F)
spades_len <- ctg_len$V2

ctg_len <- read.delim('Mice_meta_3_athena.len', head=F)
athena_len <- ctg_len$V2
method <- c(rep("WGS_metaSPAdes", length(wgs_len)),
                 rep("stLFR_metaSPAdes", length(spades_len)),
                 rep("stLFR_Athena", length(athena_len)))
rank <- c(rank(-wgs_len), rank(-spades_len), rank(-athena_len))
len <- c(wgs_len, spades_len, athena_len)

#head(human1_ctg_len)

df <- data.frame(method=method,
                 length=len,
                 rank=rank)
#head(df)
df<-df[df$length>=1000,]
p6<-ggplot(df, aes(x=log10(rank), y=length, group=method)) +
          geom_line(aes(color=method)) + 
          theme_minimal() +
          theme(legend.position="top") +
          ggtitle(label="f. Mice Sample 3")
          #scale_x_continuous(name="rank")


library(ggpubr)

pp <- ggarrange(p1, p2, p3, p4, p5, p6, ncol=3, nrow=2,
              common.legend=TRUE,
              legend="top")

pp