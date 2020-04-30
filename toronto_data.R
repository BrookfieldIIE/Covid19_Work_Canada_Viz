

vismin_full <- vismin[V15==1 & V18==1]
partime_full <- vismin[V9==1 & V18==1]
age_full <- vismin[V9==1 & V15==1]

work.styles.to.plot.toronto <- work.styles.to.plot[,.(noc_title,NOC1610,able.wfh,`Exposed to Disease or Infections`,`Physical Proximity`,row)]

vismin_full[,c("V14","V15","V16","V17","V18","V19","V24","V25"):=NULL]
vismin_full[V9==1,V8:="ALL"]
vismin_full[V9==2,V8:="VISMIN"]
vismin_full[,c("V9","V10"):=NULL]
names(vismin_full) <- c("CAT_VISMIN","NOC","emp","MED.INC","AVG.INC","NOC_4")
vismin_wide <- dcast(vismin_full,NOC ~ CAT_VISMIN,value.var=c("emp","MED.INC","AVG.INC"))

partime_full[,c("V8","V9","V10","V17","V18","V19","V24","V25","V27","V28"):=NULL]
partime_full[V15%in%c(2,3),V14:="PARTTIME"]
partime_full <- partime_full[V15!=4]
partime_full[V15==1,V14:="ALL_WORKERS"]
partime_full[,c("V15","V16"):=NULL]
names(partime_full) <- c("WORKAC","NOC","TOTAL","NOC_4")
partime_wide <- dcast(partime_full,NOC ~ WORKAC,value.var=c("TOTAL"),fun.aggregate=sum)

age_full[,c("V8","V9","V10","V14","V15","V16","V24","V25"):=NULL]
age_full <- age_full[V18%in%c(1,4)]
age_full[,c("V18","V19","V27","V28"):=NULL]
names(age_full) <- c("Age","NOC","TOTAL","NOC_4")

age_full[Age=="Total - Age",Age:="Everyone"]
age_full[Age != "Everyone",Age:="Older"]
age_wide <- dcast(age_full,NOC ~ Age,value.var=c("TOTAL"))


setkey(work.styles.to.plot.toronto,noc_title)
setkey(vismin_wide,NOC)

work.styles.to.plot.toronto <- work.styles.to.plot.toronto[vismin_wide,nomatch=0]
setkey(age_wide,NOC)
work.styles.to.plot.toronto <- work.styles.to.plot.toronto[age_wide,nomatch=0]
setkey(partime_wide,NOC)
work.styles.to.plot.toronto <- work.styles.to.plot.toronto[partime_wide,nomatch=0]

work.styles.to.plot.toronto[,share.risk:=Older/Everyone]
work.styles.to.plot.toronto[,share.part:=PARTTIME/ALL_WORKERS]
work.styles.to.plot.toronto[,Share.vm:=emp_VISMIN/emp_ALL]

names(work.styles.to.plot.toronto) <- c("noc_title","NOC1610","able.wfh","Exposed to Disease or Infections","Physical Proximity","row","emp","emp_VISMIN",
                                        "MEDINC_TOT","MEDINC_VM","AVGINC_TOT","AVGINC_VM","high.risk.65","Total_age",'ALL_WORKERS',"PARTTIME","share.risk","share.part","Share.vm")
work.styles.to.plot <- work.styles.to.plot.toronto

