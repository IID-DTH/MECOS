library(ggplot2)

hgt_stat_table<-read.delim("hgt_stat_partial",header=T)
hgt_data <- data.frame(hgt_stat_table)
p1<-ggplot(hgt_data, aes(fill=type, y=value, x=method)) + 
    geom_bar(position="dodge", stat="identity") +
    labs(title="", x="", y="count", fill="") +
    facet_wrap(~group)
p1