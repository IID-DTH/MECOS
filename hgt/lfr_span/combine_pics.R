library(ggpubr)

pp1<-ggarrange(pic_1, pic_2, nrow=2, ncol=1,
              #labels=c("a", "b", "", ""),
              common.legend=T,
              align="hv", legend="bottom")



pp2<-ggarrange(pic_3, pic_4, nrow=2, ncol=1,
              #labels=c("a", "b", "", ""),
              common.legend=T,
              align="hv", legend="bottom")
pp<-ggarrange(pp1, pp2, nrow=1, ncol=2,
              labels=c("a", "b", "", ""),
              common.legend=F,
              align="hv", legend="top")
pp