library(shiny)
library(stringr)
library(data.table)
library(ggplot2)
library(plotly)
library(scrollytell)
library(scales)

load("data/work_styles_main.RDA")
load("data/noc.vis.2016.vismin.wide.RDA")
emp.data <- fread("data/tech_emp_by_occ.csv")
load("data/parttime.RDA")
load("data/age.RDA")


BF.Base.Theme <- ggplot2::theme(panel.background = ggplot2::element_rect(fill="transparent", colour=NA), #Make sure plot area background is transparent
                                plot.background = ggplot2::element_rect(fill="transparent", colour=NA), #Make sure render area background is transparent
                                axis.line = ggplot2::element_line(size=0.25, colour = "#B1B8BC"), #Set axis line width and set colour to grey
                                axis.ticks = ggplot2::element_line(size=0.25, colour = "#B1B8BC"), #Set axis tick width and set colour to grey
                                panel.grid.major = ggplot2::element_blank(), #Remove the panel grid lines
                                panel.grid.minor = ggplot2::element_blank(), #Remove the panel grid lines
                                text = ggplot2::element_text(color="white"), #Set the font for every text element (except for geom elements)
                                plot.title = ggplot2::element_text(size=9,color="#072b49"), #Format figure number
                                plot.subtitle = ggplot2::element_text(size=12,color="#072b49"), #Format main title
                                plot.caption = ggplot2::element_text(face="italic", size=8.2, margin=ggplot2::margin(t=10),hjust=0,colour="#072b49"), #Format for caption and other notes
                                legend.background = ggplot2::element_rect(fill="transparent",colour=NA), #Make sure legend box is transparent (for export)
                                legend.key = ggplot2::element_blank(), #Background on each key is transparent
                                legend.box.margin = ggplot2::margin(b=4,t=6), #Set margin for the box for appropriate distance
                                legend.title = ggplot2::element_text(size=10,hjust=0.5,color="#072b49"), #Legend title text settings, also make centre it. Light so it's not as prominent
                                legend.title.align = 0.5,
                                legend.text = ggplot2::element_text(size=9,margin=ggplot2::margin(r=2),color="#072b49"), #Legend text settings. Light so it's not as prominent
                                legend.margin = ggplot2::margin(b=1), #Small margin in the bottom
                                legend.position = "top", #Set the legend to top so panel can be full width (for export)
                                legend.box.spacing = ggplot2::unit(c(0,0,0,0),units=c("cm","cm","cm","cm")), #Legend box spacing - maybe not needed?
                                axis.text.x = ggplot2::element_text(size=9, margin=ggplot2::margin(t=2),color="#072b49"), #Set axis text. Light to make it less prominent - margin is also precise
                                axis.text.y = ggplot2::element_text(size=9, margin=ggplot2::margin(r=2),color="#072b49"), #Set axis text. Light to make it less prominent - margin is also precise
                                axis.title.x = ggplot2::element_text(size=10, margin=ggplot2::margin(t=4,b=4),color="#072b49"), #Set axis title. Margin is also precise
                                axis.title.y = ggplot2::element_text(size=10, margin=ggplot2::margin(r=4,l=4),color="#072b49"))

set.colours <- function(n,
                        type = "categorical",
                        gradient.choice = "dark.blue",
                        categorical.choice = NULL,
                        special = NULL){
  #Setting all the base vectors to refer to - precise because I don't trust R's generation of gradients
  base.set <- c("dark.blue"="#072b49","light.blue"="#9cdae7","pink"="#e24585","yellow"="#FFC800",
                "magenta"="#79133E","orange"="#F7941E","green"="#82C458","teal"="#005F61","grey"="#707D85")
  dark.blue <- c("#072b49","#29486B","#3E5A7A","#546C89","#697F97","#7E91A6","#94A3B5","#A9B5C4")
  light.blue <- c("#8AD4DF","#94D7E1","#9FDBE4","#A9DFE7","#B4E3EA","#BFE7ED","#C9EBF0","#D4EFF3")
  pink <- c("#DD347A","#E04686","#E35892","#E66B9E","#E97DAA","#EC90B6","#EFA2C2","#F2B5CE")
  yellow <- c("#FFC800","#FFCD17","#FFD22E","#FFD745","#FFDC5C","#FFE173","#FFE68B","#FFEBA2")
  magenta <- c("#79133E","#85284F","#913D61","#9D5372","#A96884","#B57E95","#C293A7","#CEA9B8")
  orange <- c("#F7941E","#F79D32","#F8A746","#F9B15B","#F9BA6F","#FAC484","#FBCE98","#FCD8AD")
  green <- c("#82C458","#8DC967","#98CE76","#A4D485","#AFD994","#BADEA3","#C6E4B3","#D1E9C2")
  teal <- c("#005F61","#176D6F","#2E7C7D","#458A8C","#5C999A","#73A7A8","#8BB6B7","#A2C4C5")
  grey <- c("#707D85","#7D8890","#8A949B","#97A0A6","#A4ACB1","#B1B8BC","#B1B8BC","#B1B8BC")
  #Check if you have way too many categories - 7 is the absolute max!
  if(n > 7){
    stop("You have way too many categories. Reduce it!")
  }
  #Check if the type is categorical
  if(type == "categorical"){
    if(is.null(categorical.choice)){ #Check if a specific colour set was requested
      return(unname(base.set[1:n])) #If not then return sequential from dark blue,light blue to pink
    }
    else{
      if(length(categorical.choice)!=n){ #Check if the length of choice matches requested number of colours
        stop("You didn't have the same number of colours as you specified. Change n or categorical.choice") #This is for sanity check, not because of code
      }
      return(unname(base.set[categorical.choice])) #Return the corresponding set of colours
    }
  }
  if(type == "gradient"){ #On the otherhand, if it's a gradient
    #Set up all the gradient choices
    gra2 <- c(1, 5)
    gra3 <- c(1, 4, 7)
    gra4 <- c(1, 3, 5, 7)
    gra5 <- c(1, 2, 4, 6, 7)
    gra6 <- c(1, 2, 3, 4, 6, 7)
    gra7 <- c(1, 2, 3, 4, 5, 6, 7)
    return(get(gradient.choice)[get(str_c("gra",n))]) #Get the right number of gradients.
  }
}



set.ticks.seq <- function(max,min,unit,num.ticks=5){
  if(unit==""){ #If there are no unit
    ticks <- scales::cbreaks(c(max,min),labels= comma_format(unit=unit,sep="",big.mark = ","))
  }
  if(unit=="$"){
    ticks <- scales::cbreaks(c(max,min),labels = dollar_format(largest_with_cents = 100)) #Format money
    return(ticks)
  }
  if(unit=="%" & max >= 75){
    ticks <- scales::cbreaks(c(100,0),labels = unit_format(unit="%",sep="")) #Format percentage
    return(ticks)
  }
  else{
    ticks <- scales::cbreaks(c(max,min),labels=unit_format(unit=unit,sep=" ",big.mark = ",")) #Format percentage without the percentage sign
    return(ticks)
  }
}


work.styles.to.plot <- work.styles[element.id %in% c("4.C.2.a.3","4.C.2.c.1.b")]
work.styles.to.plot[,element.id:=NULL]
work.styles.to.plot[,noc_1:=NULL]
work.styles.to.plot <- dcast(work.styles.to.plot, noc_title + NOC1610 + able.wfh ~ element.name,value.var="V1")

emp.data[,c("V2","V3","V4"):=NULL]
names(emp.data) <- c("row","NOC691","emp")

setkey(emp.data,NOC691)
setkey(work.styles.to.plot,noc_title)
work.styles.to.plot <- work.styles.to.plot[emp.data,nomatch=0]
work.styles.to.plot <- work.styles.to.plot

setkey(noc.vis.2016.vismin.wide,OCC691)
setkey(work.styles.to.plot,noc_title)
work.styles.to.plot<-work.styles.to.plot[noc.vis.2016.vismin.wide,nomatch=0]

setkey(work.styles.to.plot,noc_title)
setkey(parttime,NOC693A)
work.styles.to.plot <- work.styles.to.plot[parttime,nomatch=0]
work.styles.to.plot[,share.part:=PARTTIME/(FULLTIME+PARTTIME)]

age[,share.risk:=high.risk.65/Total_age]
setkey(age,NOC693A)
setkey(work.styles.to.plot,noc_title)
work.styles.to.plot <-  work.styles.to.plot[age,nomatch=0]

main.plot <- function(triggers="Introduction"){
  if(triggers=="Introduction"){
    main.plot <- ggplot(work.styles.to.plot,aes(`Physical Proximity`,`Exposed to Disease or Infections`)) +
      BF.Base.Theme +
      geom_point(aes(text=paste(str_sub(noc_title,start=5),
                                "<br>",
                                "Number of Workers:",
                                comma(signif(emp,3))
      ), size=emp),fill=alpha("#14365D",alpha=0.3),colour="#14365D",alpha=0.7) +
      scale_x_continuous(limits = c(0,100),breaks=c(0,25,50,75,100),labels=c(str_wrap("Don't work near people",10),
                                                                             str_wrap("Work with others, but not closely",10),
                                                                             str_wrap("Slightly close e.g. Shared office",10),
                                                                             str_wrap("Moderately close e.g. arms length",10),
                                                                             str_wrap("Very close (near touching)",10))) +
      scale_y_continuous(limits = c(0,100),breaks = c(0,25,50,75,100),labels=c(str_wrap("Never exposed",7),
                                                                                str_wrap("Exposed once a year",7),
                                                                                str_wrap("Exposed once a month",7),
                                                                                str_wrap("Exposed once a week",7),
                                                                                str_wrap("Exposed once a day",7)))
    
    graph <- config(layout(ggplotly(main.plot,tooltip=c("text"),showlegend=FALSE,showscale=FALSE),
                           legend = list(orientation = 'h'),
                           xaxis=list(fixedrange=TRUE), 
                           yaxis=list(fixedrange=TRUE),
                           showlegend = FALSE),
                    displayModeBar=F)
    graph
  }
  else if(triggers=="Health Workers"){
    work.styles.to.plot[,trigger.dum:="0"]
    work.styles.to.plot[NOC1610=="3 Health occupations",trigger.dum:="1"]
    main.plot <- ggplot(work.styles.to.plot,aes(`Physical Proximity`,`Exposed to Disease or Infections`)) +
      BF.Base.Theme +
      geom_point(aes(text=paste(str_sub(noc_title,start=5),
                                "<br>",
                                "Number of Workers:",
                                comma(signif(emp,3))
      ), size=emp,fill=trigger.dum,colour=trigger.dum),alpha=0.7) +
      scale_fill_manual(values=c(alpha("#14365D",0.2),alpha("#DD347A",0.3))) +
      scale_colour_manual(values=c(alpha("#14365D",0.3),"#DD347A")) +
      scale_x_continuous(limits = c(0,100),breaks=c(0,25,50,75,100),labels=c(str_wrap("Don't work near people",10),
                                                                             str_wrap("Work with others, but not closely",10),
                                                                             str_wrap("Slightly close e.g. Shared office",10),
                                                                             str_wrap("Moderately close e.g. arms length",10),
                                                                             str_wrap("Very close (near touching)",10))) +
      scale_y_continuous(limits = c(0,100),breaks = c(0,25,50,75,100),labels=c(str_wrap("Never exposed",7),
                                                                               str_wrap("Exposed once a year",7),
                                                                               str_wrap("Exposed once a month",7),
                                                                               str_wrap("Exposed once a week",7),
                                                                               str_wrap("Exposed once a day",7))) +
      annotate("segment",
               x=93.25,
               y=97.5,
               xend=63,
               yend=97.5,
               colour = "#e24585",
               linetype = "dotted") +
      annotate("text",
               x = 63,
               y = 97.5,
               colour = "#e24585",
               label = "Respiratory Therapists",
               hjust = 1,
               size = 9*0.352777778) +
      annotate("segment",
               x=99.25,
               y=94.5,
               xend=87,
               yend=70,
               colour = "#e24585",
               linetype = "dotted") +
      annotate("text",
               x = 87,
               y = 70,
               colour = "#e24585",
               label = "Dentist",
               hjust = 0,
               size = 9*0.352777778)+
      annotate("segment",
               x=85.375,
               y=87.375,
               xend=62.5,
               yend=62.5,
               colour = "#e24585",
               linetype = "dotted") +
      annotate("text",
               x = 62.5,
               y = 62.5,
               colour = "#e24585",
               label = "Registered Nurses",
               hjust = 0,
               size = 9*0.352777778)
    
    graph <- config(layout(ggplotly(main.plot,tooltip=c("text"),showlegend=FALSE,showscale=FALSE),
                           legend = list(orientation = 'h'),
                           xaxis=list(fixedrange=TRUE), 
                           yaxis=list(fixedrange=TRUE),
                           showlegend = FALSE),
                    displayModeBar=F)
    graph$x$data[[4]]$textposition <- "middle left"
    graph$x$data[[6]]$textposition <- "middle left"
    graph$x$data[[8]]$textposition <- "middle left"
    graph
  }
  
  else if(triggers=="Education Workers"){
    work.styles.to.plot[,trigger.dum:="0"]
    work.styles.to.plot[str_sub(noc_title,1,4)%in%c("0421","0422","4011","4012","4021","4031","4032","4033","4214","4413"),trigger.dum:="1"]
    main.plot <- ggplot(work.styles.to.plot,aes(`Physical Proximity`,`Exposed to Disease or Infections`)) +
      BF.Base.Theme +
      geom_point(aes(text=paste(str_sub(noc_title,start=5),
                                "<br>",
                                "Number of Workers:",
                                comma(signif(emp,3))
      ), size=emp,fill=trigger.dum,colour=trigger.dum),alpha=0.7) +
      scale_fill_manual(values=c(alpha("#14365D",0.2),alpha("#DD347A",0.3))) +
      scale_colour_manual(values=c(alpha("#14365D",0.3),"#DD347A")) +
      scale_x_continuous(limits = c(0,100),breaks=c(0,25,50,75,100),labels=c(str_wrap("Don't work near people",10),
                                                                             str_wrap("Work with others, but not closely",10),
                                                                             str_wrap("Slightly close e.g. Shared office",10),
                                                                             str_wrap("Moderately close e.g. arms length",10),
                                                                             str_wrap("Very close (near touching)",10))) +
      scale_y_continuous(limits = c(0,100),breaks = c(0,25,50,75,100),labels=c(str_wrap("Never exposed",7),
                                                                               str_wrap("Exposed once a year",7),
                                                                               str_wrap("Exposed once a month",7),
                                                                               str_wrap("Exposed once a week",7),
                                                                               str_wrap("Exposed once a day",7)))+
      annotate("segment",
               x=69.5,
               y=16.75,
               xend=47,
               yend=50,
               colour = "#e24585",
               linetype = "dotted") +
      annotate("text",
               x = 47,
               y = 50,
               colour = "#e24585",
               label = "Secondary School Teachers",
               hjust = 0,
               size = 9*0.352777778) +
      annotate("segment",
               x=83,
               y=50,
               xend=70,
               yend=77,
               colour = "#e24585",
               linetype = "dotted") +
      annotate("text",
               x = 70,
               y = 77,
               colour = "#e24585",
               label = "Early Childhood Educators",
               hjust = 0,
               size = 9*0.352777778)
    
    graph <- config(layout(ggplotly(main.plot,tooltip=c("text"),showlegend=FALSE,showscale=FALSE),
                           legend = list(orientation = 'h'),
                           xaxis=list(fixedrange=TRUE), 
                           yaxis=list(fixedrange=TRUE),
                           showlegend = FALSE),
                    displayModeBar=F)
    graph$x$data[[4]]$textposition <- "middle left"
    graph$x$data[[6]]$textposition <- "middle left"
    graph
  }
  else if(triggers=="Introduction2"){
    work.styles.to.plot[,trigger.dum:="0"]
    work.styles.to.plot[str_sub(noc_title,1,4) %in% c("3112","6731","5121"),trigger.dum:="1"]
    main.plot <- ggplot(work.styles.to.plot,aes(`Physical Proximity`,`Exposed to Disease or Infections`)) +
      BF.Base.Theme +
      geom_point(aes(text=paste(str_sub(noc_title,start=5),
                                "<br>",
                                "Number of Workers:",
                                comma(signif(emp,3))
      ), size=emp,fill=trigger.dum,colour=trigger.dum),alpha=0.7) +
      scale_fill_manual(values=c("#14365D","#DD347A")) +
      scale_colour_manual(values=c("#14365D","#DD347A")) +
      scale_x_continuous(limits = c(0,100),breaks=c(0,25,50,75,100),labels=c(str_wrap("Don't work near people",10),
                                                                             str_wrap("Work with others, but not closely",10),
                                                                             str_wrap("Slightly close e.g. Shared office",10),
                                                                             str_wrap("Moderately close e.g. arms length",10),
                                                                             str_wrap("Very close (near touching)",10))) +
      scale_y_continuous(limits = c(0,100),breaks = c(0,25,50,75,100),labels=c(str_wrap("Never exposed",7),
                                                                               str_wrap("Exposed once a year",7),
                                                                               str_wrap("Exposed once a month",7),
                                                                               str_wrap("Exposed once a week",7),
                                                                               str_wrap("Exposed once a day",7))) +
      annotate("segment",
               x=90.5,
               y=100,
               xend=70,
               yend=100,
               colour = "#e24585",
               linetype = "dotted") +
      annotate("text",
               x = 70,
               y = 100,
               colour = "#e24585",
               label = "General Practitioners",
               hjust = 0,
               size = 9*0.352777778) +
      annotate("segment",
               x=41.75,
               y=51.50,
               xend=31,
               yend=75,
               colour = "#e24585",
               linetype = "dotted") +
      annotate("text",
               x = 31,
               y = 75,
               colour = "#e24585",
               label = "Light Duty Cleaners",
               hjust = 0,
               size = 9*0.352777778)+
      annotate("segment",
               x=31.375,
               y=3.625,
               xend=25,
               yend=25,
               colour = "#e24585",
               linetype = "dotted") +
      annotate("text",
               x = 25,
               y = 25,
               colour = "#e24585",
               label = "Authors and Writers",
               hjust = 0,
               size = 9*0.352777778)
    
    graph <- config(layout(ggplotly(main.plot,tooltip=c("text"),showlegend=FALSE,showscale=FALSE),
                           legend = list(orientation = 'h'),
                           xaxis=list(fixedrange=TRUE), 
                           yaxis=list(fixedrange=TRUE),
                           showlegend = FALSE),
                    displayModeBar=F)
    graph$x$data[[4]]$textposition <- "middle left"
    graph$x$data[[6]]$textposition <- "middle left"
    graph$x$data[[8]]$textposition <- "middle left"
    graph
  }
  
  else if(triggers=="Transport Workers"){
    work.styles.to.plot[,trigger.dum:="0"]
    work.styles.to.plot[NOC1610=="7 Trades, transport and equipment operators and related occupations",trigger.dum:="1"]
    main.plot <- ggplot(work.styles.to.plot,aes(`Physical Proximity`,`Exposed to Disease or Infections`)) +
      BF.Base.Theme +
      geom_point(aes(text=paste(str_sub(noc_title,start=5),
                                "<br>",
                                "Number of Workers:",
                                comma(signif(emp,3))
      ), size=emp,fill=trigger.dum,colour=trigger.dum),alpha=0.7) +
      scale_fill_manual(values=c(alpha("#14365D",0.2),alpha("#DD347A",0.3))) +
      scale_colour_manual(values=c(alpha("#14365D",0.3),"#DD347A")) +
      scale_x_continuous(limits = c(0,100),breaks=c(0,25,50,75,100),labels=c(str_wrap("Don't work near people",10),
                                                                             str_wrap("Work with others, but not closely",10),
                                                                             str_wrap("Slightly close e.g. Shared office",10),
                                                                             str_wrap("Moderately close e.g. arms length",10),
                                                                             str_wrap("Very close (near touching)",10))) +
      scale_y_continuous(limits = c(0,100),breaks = c(0,25,50,75,100),labels=c(str_wrap("Never exposed",7),
                                                                               str_wrap("Exposed once a year",7),
                                                                               str_wrap("Exposed once a month",7),
                                                                               str_wrap("Exposed once a week",7),
                                                                               str_wrap("Exposed once a day",7))) +
      annotate("segment",
               x=66.75,
               y=13.25,
               xend=42,
               yend=55,

               colour = "#e24585",
               linetype = "dotted") +
      annotate("text",
               x=42,
               y=55,
               colour = "#e24585",
               label = "Delivery Couriers",
               hjust = 1,
               size = 9*0.352777778) +
      annotate("segment",
               x=78.75,
               y=52.167,
               xend=82,
               yend=65,
               colour = "#e24585",
               linetype = "dotted") +
      annotate("text",
               x = 82,
               y = 65,
               colour = "#e24585",
               label = "Bus Drivers",
               hjust = 0,
               size = 9*0.352777778)+
      annotate("segment",
               x=78.75,
               y=25,
               xend=63,
               yend=77,
               colour = "#e24585",
               linetype = "dotted") +
      annotate("text",
               x=63,
               y=77,
               colour = "#e24585",
               label = "Taxi/Uber Drivers",
               hjust = 0,
               size = 9*0.352777778)
    
    graph <- config(layout(ggplotly(main.plot,tooltip=c("text"),showlegend=FALSE,showscale=FALSE),
                           legend = list(orientation = 'h'),
                           xaxis=list(fixedrange=TRUE), 
                           yaxis=list(fixedrange=TRUE),
                           showlegend = FALSE),
                    displayModeBar=F)
    graph$x$data[[4]]$textposition <- "middle left"
    graph$x$data[[6]]$textposition <- "middle right"
    graph$x$data[[8]]$textposition <- "middle left"
    graph
  }
  else if(triggers=="Work From Home"){
    work.styles.to.plot[,trigger.dum:="0"]
    work.styles.to.plot[able.wfh>=0.55,trigger.dum:="1"]
    main.plot <- ggplot(work.styles.to.plot,aes(`Physical Proximity`,`Exposed to Disease or Infections`)) +
      BF.Base.Theme +
      geom_point(aes(text=paste(str_sub(noc_title,start=5),
                                "<br>",
                                "Number of Workers:",
                                comma(signif(emp,3))
      ), size=emp,fill=trigger.dum,colour=trigger.dum),alpha=0.7) +
      scale_fill_manual(values=c(alpha("#DD347A",0.3),alpha("#14365D",0.3))) +
      scale_colour_manual(values=c("#DD347A","#14365D")) +
      scale_x_continuous(limits = c(0,100),breaks=c(0,25,50,75,100),labels=c(str_wrap("Don't work near people",10),
                                                                             str_wrap("Work with others, but not closely",10),
                                                                             str_wrap("Slightly close e.g. Shared office",10),
                                                                             str_wrap("Moderately close e.g. arms length",10),
                                                                             str_wrap("Very close (near touching)",10))) +
      scale_y_continuous(limits = c(0,100),breaks = c(0,25,50,75,100),labels=c(str_wrap("Never exposed",7),
                                                                               str_wrap("Exposed once a year",7),
                                                                               str_wrap("Exposed once a month",7),
                                                                               str_wrap("Exposed once a week",7),
                                                                               str_wrap("Exposed once a day",7)))
    
    graph <- config(layout(ggplotly(main.plot,tooltip=c("text"),showlegend=FALSE,showscale=FALSE),
                           legend = list(orientation = 'h'),
                           xaxis=list(fixedrange=TRUE), 
                           yaxis=list(fixedrange=TRUE),
                           showlegend = FALSE),
                    displayModeBar=F)
    graph
  }
  else if(triggers=="Work From Home: Focus"){
    work.styles.to.plot[,trigger.dum:="1"]
    work.styles.to.plot[noc_title=="4412 Home support workers, housekeepers and related occupations",trigger.dum:="0"]
    main.plot <- ggplot(work.styles.to.plot,aes(`Physical Proximity`,`Exposed to Disease or Infections`)) +
      BF.Base.Theme +
      geom_point(aes(text=paste(str_sub(noc_title,start=5),
                                "<br>",
                                "Number of Workers:",
                                comma(signif(emp,3))
      ), size=emp,fill=trigger.dum,colour=trigger.dum),alpha=0.7) +
      scale_fill_manual(values=c(alpha("#DD347A",0.3),alpha("#14365D",0.1))) +
      scale_colour_manual(values=c("#DD347A",alpha("#14365D",0.3))) +
      scale_x_continuous(limits = c(0,100),breaks=c(0,25,50,75,100),labels=c(str_wrap("Don't work near people",10),
                                                                             str_wrap("Work with others, but not closely",10),
                                                                             str_wrap("Slightly close e.g. Shared office",10),
                                                                             str_wrap("Moderately close e.g. arms length",10),
                                                                             str_wrap("Very close (near touching)",10))) +
      scale_y_continuous(limits = c(0,100),breaks = c(0,25,50,75,100),labels=c(str_wrap("Never exposed",7),
                                                                               str_wrap("Exposed once a year",7),
                                                                               str_wrap("Exposed once a month",7),
                                                                               str_wrap("Exposed once a week",7),
                                                                               str_wrap("Exposed once a day",7)))
    
    graph <- config(layout(ggplotly(main.plot,tooltip=c("text"),showlegend=FALSE,showscale=FALSE),
                           legend = list(orientation = 'h'),
                           xaxis=list(fixedrange=TRUE), 
                           yaxis=list(fixedrange=TRUE),
                           showlegend = FALSE),
                    displayModeBar=F)
    graph
  }
  
  else if(triggers=="Older Folks"){
    work.styles.to.plot[,trigger.dum:="0"]
    work.styles.to.plot[share.risk>=0.1,trigger.dum:="1"]
    main.plot <- ggplot(work.styles.to.plot,aes(`Physical Proximity`,`Exposed to Disease or Infections`)) +
      BF.Base.Theme +
      geom_point(aes(text=paste(str_sub(noc_title,start=5),
                                "<br>",
                                "Number of Workers:",
                                comma(signif(emp,3))
      ), size=emp,fill=trigger.dum,colour=trigger.dum),alpha=0.7) +
      scale_fill_manual(values=c(alpha("#14365D",0.1),alpha("#DD347A",0.3))) +
      scale_colour_manual(values=c(alpha("#14365D",0.3),"#DD347A")) +
      scale_x_continuous(limits = c(0,100),breaks=c(0,25,50,75,100),labels=c(str_wrap("Don't work near people",10),
                                                                             str_wrap("Work with others, but not closely",10),
                                                                             str_wrap("Slightly close e.g. Shared office",10),
                                                                             str_wrap("Moderately close e.g. arms length",10),
                                                                             str_wrap("Very close (near touching)",10))) +
      scale_y_continuous(limits = c(0,100),breaks = c(0,25,50,75,100),labels=c(str_wrap("Never exposed",7),
                                                                               str_wrap("Exposed once a year",7),
                                                                               str_wrap("Exposed once a month",7),
                                                                               str_wrap("Exposed once a week",7),
                                                                               str_wrap("Exposed once a day",7)))+
      annotate("segment",
               x=78.75,
               y=52.167,
               xend=82,
               yend=65,
               colour = "#e24585",
               linetype = "dotted") +
      annotate("text",
               x = 82,
               y = 65,
               colour = "#e24585",
               label = "Bus Drivers",
               hjust = 0,
               size = 9*0.352777778)+
      annotate("segment",
               x=78.75,
               y=25,
               xend=63,
               yend=77,
               colour = "#e24585",
               linetype = "dotted") +
      annotate("text",
               x=63,
               y=77,
               colour = "#e24585",
               label = "Taxi/Uber Drivers",
               hjust = 0,
               size = 9*0.352777778)
    
    graph <- config(layout(ggplotly(main.plot,tooltip=c("text"),showlegend=FALSE,showscale=FALSE),
                           legend = list(orientation = 'h'),
                           xaxis=list(fixedrange=TRUE), 
                           yaxis=list(fixedrange=TRUE),
                           showlegend = FALSE),
                    displayModeBar=F)
    graph$x$data[[4]]$textposition <- "middle right"
    graph$x$data[[6]]$textposition <- "middle left"
    graph
  }
  
  else if(triggers=="Second order"){
    main.plot <- ggplot(work.styles.to.plot,aes(`Physical Proximity`,`Exposed to Disease or Infections`)) +
      BF.Base.Theme +
      geom_point(aes(text=paste(str_sub(noc_title,start=5),
                                "<br>",
                                "Number of Workers:",
                                comma(signif(emp,3))
      ), size=emp),fill=alpha("#14365D",alpha=0.3),colour="#14365D",alpha=0.7) +
      scale_x_continuous(limits = c(0,100),breaks=c(0,25,50,75,100),labels=c(str_wrap("Don't work near people",10),
                                                                             str_wrap("Work with others, but not closely",10),
                                                                             str_wrap("Slightly close e.g. Shared office",10),
                                                                             str_wrap("Moderately close e.g. arms length",10),
                                                                             str_wrap("Very close (near touching)",10))) +
      scale_y_continuous(limits = c(0,100),breaks = c(0,25,50,75,100),labels=c(str_wrap("Never exposed",7),
                                                                               str_wrap("Exposed once a year",7),
                                                                               str_wrap("Exposed once a month",7),
                                                                               str_wrap("Exposed once a week",7),
                                                                               str_wrap("Exposed once a day",7)))
    
    graph <- config(layout(ggplotly(main.plot,tooltip=c("text"),showlegend=FALSE,showscale=FALSE),
                           legend = list(orientation = 'h'),
                           xaxis=list(fixedrange=TRUE), 
                           yaxis=list(fixedrange=TRUE),
                           showlegend = FALSE),
                    displayModeBar=F)
    graph
  }
  else if(triggers=="Income Precarity"){
    work.styles.to.plot[,trigger.dum:="0"]
    work.styles.to.plot[MEDINC_TOT<=32554,trigger.dum:="1"]
    main.plot <- ggplot(work.styles.to.plot,aes(`Physical Proximity`,`Exposed to Disease or Infections`)) +
      BF.Base.Theme +
      geom_point(aes(text=paste(str_sub(noc_title,start=5),
                                "<br>",
                                "Number of Workers:",
                                comma(signif(emp,3))
      ), size=emp,fill=trigger.dum,colour=trigger.dum),alpha=0.7) +
      scale_fill_manual(values=c(alpha("#14365D",0.2),alpha("#DD347A",0.3))) +
      scale_colour_manual(values=c(alpha("#14365D",0.3),"#DD347A")) +
      scale_x_continuous(limits = c(0,100),breaks=c(0,25,50,75,100),labels=c(str_wrap("Don't work near people",10),
                                                                             str_wrap("Work with others, but not closely",10),
                                                                             str_wrap("Slightly close e.g. Shared office",10),
                                                                             str_wrap("Moderately close e.g. arms length",10),
                                                                             str_wrap("Very close (near touching)",10))) +
      scale_y_continuous(limits = c(0,100),breaks = c(0,25,50,75,100),labels=c(str_wrap("Never exposed",7),
                                                                               str_wrap("Exposed once a year",7),
                                                                               str_wrap("Exposed once a month",7),
                                                                               str_wrap("Exposed once a week",7),
                                                                               str_wrap("Exposed once a day",7)))
    
    graph <- config(layout(ggplotly(main.plot,tooltip=c("text"),showlegend=FALSE,showscale=FALSE),
                           legend = list(orientation = 'h'),
                           xaxis=list(fixedrange=TRUE), 
                           yaxis=list(fixedrange=TRUE),
                           showlegend = FALSE),
                    displayModeBar=F)
    graph
  }
  else if(triggers=="Part Time Workers"){
    work.styles.to.plot[,trigger.dum:="0"]
    work.styles.to.plot[share.part>=0.5,trigger.dum:="1"]
    main.plot <- ggplot(work.styles.to.plot,aes(`Physical Proximity`,`Exposed to Disease or Infections`)) +
      BF.Base.Theme +
      geom_point(aes(text=paste(str_sub(noc_title,start=5),
                                "<br>",
                                "Number of Workers:",
                                comma(signif(emp,3))
      ), size=emp,fill=trigger.dum,colour=trigger.dum),alpha=0.7) +
      scale_fill_manual(values=c(alpha("#14365D",0.1),alpha("#DD347A",0.3))) +
      scale_colour_manual(values=c(alpha("#14365D",0.3),"#DD347A")) +
      scale_x_continuous(limits = c(0,100),breaks=c(0,25,50,75,100),labels=c(str_wrap("Don't work near people",10),
                                                                             str_wrap("Work with others, but not closely",10),
                                                                             str_wrap("Slightly close e.g. Shared office",10),
                                                                             str_wrap("Moderately close e.g. arms length",10),
                                                                             str_wrap("Very close (near touching)",10))) +
      scale_y_continuous(limits = c(0,100),breaks = c(0,25,50,75,100),labels=c(str_wrap("Never exposed",7),
                                                                               str_wrap("Exposed once a year",7),
                                                                               str_wrap("Exposed once a month",7),
                                                                               str_wrap("Exposed once a week",7),
                                                                               str_wrap("Exposed once a day",7)))
    
    graph <- config(layout(ggplotly(main.plot,tooltip=c("text"),showlegend=FALSE,showscale=FALSE),
                           legend = list(orientation = 'h'),
                           xaxis=list(fixedrange=TRUE), 
                           yaxis=list(fixedrange=TRUE),
                           showlegend = FALSE),
                    displayModeBar=F)
    graph
  }
  else if(triggers=="Visible Minority Workers"){
    work.styles.to.plot[,trigger.dum:="0"]
    work.styles.to.plot[Share.vm>=0.21,trigger.dum:="1"]
    main.plot <- ggplot(work.styles.to.plot,aes(`Physical Proximity`,`Exposed to Disease or Infections`)) +
      BF.Base.Theme +
      geom_point(aes(text=paste(str_sub(noc_title,start=5),
                                "<br>",
                                "Number of Workers:",
                                comma(signif(emp,3))
      ), size=emp,fill=trigger.dum,colour=trigger.dum),alpha=0.7) +
      scale_fill_manual(values=c(alpha("#14365D",0.1),alpha("#DD347A",0.3))) +
      scale_colour_manual(values=c(alpha("#14365D",0.3),"#DD347A")) +
      scale_x_continuous(limits = c(0,100),breaks=c(0,25,50,75,100),labels=c(str_wrap("Don't work near people",10),
                                                                             str_wrap("Work with others, but not closely",10),
                                                                             str_wrap("Slightly close e.g. Shared office",10),
                                                                             str_wrap("Moderately close e.g. arms length",10),
                                                                             str_wrap("Very close (near touching)",10))) +
      scale_y_continuous(limits = c(0,100),breaks = c(0,25,50,75,100),labels=c(str_wrap("Never exposed",7),
                                                                               str_wrap("Exposed once a year",7),
                                                                               str_wrap("Exposed once a month",7),
                                                                               str_wrap("Exposed once a week",7),
                                                                               str_wrap("Exposed once a day",7)))
    
    graph <- config(layout(ggplotly(main.plot,tooltip=c("text"),showlegend=FALSE,showscale=FALSE),
                           legend = list(orientation = 'h'),
                           xaxis=list(fixedrange=TRUE), 
                           yaxis=list(fixedrange=TRUE),
                           showlegend = FALSE),
                    displayModeBar=F)
    graph
  }
}

final.plot <- function(occupation_focus=""){
  work.styles.to.plot[,occ.focus:="0"]
  work.styles.to.plot[str_sub(noc_title,5)==occupation_focus,occ.focus:="1"]
  main.plot <- ggplot(work.styles.to.plot,aes(`Physical Proximity`,`Exposed to Disease or Infections`)) +
    BF.Base.Theme +
    geom_point(aes(text=paste(str_sub(noc_title,start=5),
                              "<br>",
                              "Number of Workers:",
                              comma(signif(emp,3))
    ), size=emp,fill=occ.focus,colour=occ.focus),alpha=0.7) +
    scale_fill_manual(values=c(alpha("#14365D",0.5),alpha("#DD347A",0.8))) +
    scale_colour_manual(values=c(alpha("#14365D",0.5),"#DD347A")) +
    scale_x_continuous(limits = c(0,100),breaks=c(0,25,50,75,100),labels=c(str_wrap("Don't work near people",20),
                                                                           str_wrap("Work with others, but not closely",20),
                                                                           str_wrap("Slightly close e.g. Shared office",20),
                                                                           str_wrap("Moderately close e.g. arms length",20),
                                                                           str_wrap("Very close (near touching)",20))) +
    scale_y_continuous(limits = c(0,100),breaks = c(0,25,50,75,100),labels=c(str_wrap("Never exposed",20),
                                                                             str_wrap("Exposed once a year",20),
                                                                             str_wrap("Exposed once a month",20),
                                                                             str_wrap("Exposed once a week",20),
                                                                             str_wrap("Exposed once a day",20)))
  
  graph <- config(layout(ggplotly(main.plot,tooltip=c("text"),showlegend=FALSE,showscale=FALSE),
                         legend = list(orientation = 'h'),
                         xaxis=list(fixedrange=TRUE), 
                         yaxis=list(fixedrange=TRUE),
                         showlegend = FALSE),
                  displayModeBar=F)
  graph
}






