library(data.table)
library(SDMTools)
library(stringr)


load("data/crosswalk.RDA")
work.styles <- fread("data/Work_Context.txt")

names(work.styles)<-c("onet","element.id","element.name","scale.id","cat","value","N","std","uci","lci","suppress","relevance","date","source") 

setkey(work.styles,onet)
setkey(crosswalk,onet)

work.styles<-work.styles[crosswalk,nomatch=0]
work.styles <- work.styles[scale.id=="CX"]
work.styles<-work.styles[,.(mean(value)),by=.(noc_title,element.id,element.name)]

work.styles[,V1:=100*(V1-1)/4]





###############################
#Gss data prep
#############################
gss.2016 <- fread("data/gss-12M0030X-E-2016-c-30_F1.csv")
gss.2016 <- gss.2016[,.(RECID,NOC1610,WTI_110,WGHT_PER)]
gss.2016 <- gss.2016[NOC1610<=10]
gss.2016[,NOC1610:=as.character(NOC1610)]
gss.2016[NOC1610=="1",NOC1610:="0 Management Occupations"]
gss.2016[NOC1610=="2",NOC1610:="1 Business, finance, and administration occupations"]
gss.2016[NOC1610=="3",NOC1610:="2 Natural and applied sciences and related occupations"]
gss.2016[NOC1610=="4",NOC1610:="3 Health occupations"]
gss.2016[NOC1610=="5",NOC1610:="4 Occupations in education, law and social, community and government services"]
gss.2016[NOC1610=="6",NOC1610:="5 Occupations in art, culture, recreation and sport"]
gss.2016[NOC1610=="7",NOC1610:="6 Sales and service occupations"]
gss.2016[NOC1610=="8",NOC1610:="7 Trades, transport and equipment operators and related occupations"]
gss.2016[NOC1610=="9",NOC1610:="8 Natural resources, agriculture and related production occupations"]
gss.2016[NOC1610=="10",NOC1610:="9 Occupations in manufacturing and utilities"]

gss.2016 <- gss.2016[WTI_110<6]
gss.2016[,able.home:=1]
gss.2016[WTI_110==3,able.home:=0]
consolidated <- gss.2016[,wt.mean(able.home,WGHT_PER),by=NOC1610]

save(consolidated,file="data/gss_home_ability_consolidated.RDA")





#Combine with the main file
work.styles[,noc_1:=str_sub(noc_title,1,1)]
consolidated[,noc_1:=str_sub(NOC1610,1,1)]
names(consolidated) <- c("NOC1610","able.wfh","noc_1")
setkey(work.styles,noc_1)
setkey(consolidated,noc_1)
work.styles <- work.styles[consolidated,nomatch=0]

save(work.styles,file="data/work_styles_main.RDA")


###############################################
load("data/noc_vismin.RDA")
noc.vis.2016.vismin.wide <- dcast(noc.vis.2016.vismin,OCC691 ~ VIS15,value.var=c("TOT","MED.INC","AVG.INC"))
names(noc.vis.2016.vismin.wide) <- c("OCC691","TOT_ALL","TOT_VM","MEDINC_TOT","MEDINC_VM","AVGINC_TOT","AVGINC_VM")
noc.vis.2016.vismin.wide[,Share.vm:=TOT_VM/TOT_ALL]
save(noc.vis.2016.vismin.wide,file="data/noc.vis.2016.vismin.wide.RDA")









