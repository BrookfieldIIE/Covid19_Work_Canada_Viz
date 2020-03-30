#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


source("definitions.R")

# Define UI for application that draws a histogram
ui <- fluidPage(theme="style.css",

    
    # Application title
    div(class="header",
        style = "background: #fff; margin-left: 0%; margin-right: 0%; font-size: 16px !important; max-width: unset; padding-right: 10%; padding-left: 10%; padding-bottom: 20px; padding-top:16px; border-bottom: 6px solid #d1236c",
        includeHTML("www/header.html")),
    titlePanel("",windowTitle = "Brookfield Institute - Working From Home in the Age of CoVID-19"),
    div(class="mobilescreen",
        fluidRow(style="font-family: rooneysanslight !important; text-align:center; padding-bottom:50px",
                 p("Thank you for your interest in exploring how Covid-19 might change work in Canada."),
                 p("Unfortunately, this interactive data visualization can only be experienced on a larger screen at this time.",
                 "If you are unable to do so, please visit the",a("accompanying blog post",href="https://brookfieldinstitute.ca/"), "which explores insights from this visualization."))),

        # Show a plot of the generated distribution
    div(class="desktopscreen",
             fluidRow(
                      fluidRow(style="margin-left:0%; margin-right:0%;padding-bottom:10px",class="sectiontitlewrapper",
                               h3("Covid-19 and Work in Canada"),
                               div(style="border-top: 1px solid #707070",
                                          includeHTML("www/author_name_html.html")
                                     
                                   )
                               ),
                      fluidRow(style="margin-left:0%; margin-right:0%;",
                               div(p("COVID-19 is increasingly disrupting our economy and how we work, becoming more than a public health crisis.",
                                     "This data visualization explores these intersections, starting from identifying  which work contexts are more likely to expose workers to disease or infections.",
                                     "We then highlight where existing work and labour conditions affect such risks, as well as the economic and labour implications of new guidelines on social distancing and business closures.",
                                     "It builds on the data visualization by Lazario Gamio for the ",
                                     a("New York Times", href="https://www.nytimes.com/interactive/2020/03/15/business/economy/coronavirus-worker-risk.html"),
                                     "and uses three data sources:", 
                                     a("O*Net",href="https://www.onetonline.org/",.noWS = "after"),
                                     ",",
                                     a("General Social Survey",.noWS = "after",href="https://www23.statcan.gc.ca/imdb/p2SV.pl?Function=getSurvey&SDDS=5221"),
                                     ", and the",
                                     a("2016 Long Form Canadian Census",href="https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/index-eng.cfm"),
                                     "connected by a",
                                     a("crosswalk", href="https://brookfieldinstitute.ca/commentary/connecting-the-dots-linking-canadian-occupations-to-skills-data/"),
                                     "developed by the Brookfield Institute."),
                                   p("We will add new dimensions to this research over time, to paint a fuller picture of how COVID-19 may affect the economic precarity and risk faced by different workers. We welcome your recommendations. ")
                                   )
                               ),
                      fluidRow(style="margin-left:0%; margin-right:0%;font-family: rooneysanslight !important; text-align:center; padding-bottom:0px; border-top:1px solid #14365D",
                               "Scroll down to interact with this data visualization. It is intended to be viewed on a desktop computer."),
                      fluidRow(style="margin-left:0%; margin-right:0%;text-align:center; padding-bottom:0px; padding-top:0px",includeHTML("www/arrow_down.html")),
               scrolly_container("scr"
                               , scrolly_graph( div(style="padding-top:30%"),
                                                plotlyOutput("mainPlot"),
                                                p(style="font-family:rooneysanslight; font-size:11px; padding-left:10%; padding-top:1.5%",img(src="biie_logo.png",style="display:unset; position:unset; height:14px;width:14px"),"Visualization by the Brookfield Institute.")
                                                
                               )
                               , scrolly_sections(
                                 scrolly_section( id = "Introduction2",
                                                  label = "Canadians Working From Home",
                                                  div(style="padding-top:45%"),
                                                  div(class="sectiontitlewrapper",h2("Anatomy of the visualization")),
                                                  p("On the right is the key graph we are exploring. Each dot in this graph represents an",
                                                    span("occupation",.noWS = "after", style="font-family:rooneysansmedium !important; color: #e24585"),
                                                    ".",
                                                    span("Larger dots", style="font-family:rooneysansmedium !important; color: #e24585"),
                                                    "reflect",
                                                    span("more", style="font-family:rooneysansmedium !important; color: #e24585")
                                                    ,"people working in that occupation in Canada; smaller dots reflect", 
                                                    span("less", style="font-family:rooneysansmedium !important; color: #e24585"), 
                                                    "people working in that occupation.",
                                                    "The bottom axis indicates a worker's",
                                                    a("physical proximity", href="https://www.onetonline.org/find/descriptor/result/4.C.2.a.3"),
                                                    "to others while working; and the left hand axis indicates the frequency with which workers are",
                                                    a("exposed to diseases or infections",href="https://www.onetonline.org/find/descriptor/result/4.C.2.c.1.b"),
                                                    "on the job. These measures are from O*Net, an occupational database of worker characteristics that are generated through interviews with people working in each occupation.",
                                                    style="padding-bottom:200px"),
                                 ),
                                 scrolly_section(id = "Health Workers",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Healthcare workers experience high levels of exposure")),
                                                 p("For example, healthcare occupations, such as",
                                                   span("respiratory therapists",.noWS = "after",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   ",",
                                                   span("pharmacists",.noWS = "after",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   ",or",
                                                   span("registered nurses",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   "are occupations with a high risk of exposure to disease and infection.In response to social distancing requirements and public health guidelines, some of these occupations are shifting their service delivery models. For example,",
                                                   a("many dental clinics",href="https://oda.ca/156-you-and-your-dentist/478-covid-19-updates-from-the-oda"),
                                                   " are currently performing emergency procedures only, while many paramedical occupations, such as physiotherapists,",
                                                   a("are temporarily interacting with patients online",.noWS = "after",href="https://physiotherapy.ca/cpas-covid-19-update"),
                                                   ".",
                                                   style="padding-bottom:200px")
                                                 ),
                                 
                                 scrolly_section(id = "Education Workers",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Education workers in a rapidly changing landscape")),
                                                 p("Education workers, such as",
                                                   span("early childhood educators",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   "or",
                                                   span("secondary school teachers",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   "normally face relatively high risks in terms of both exposure and proximity. However, currently almost all educational institutions in Canada have shifted to online delivery or have temporarily closed, which reflects how abruptly labour conditions can change.",
                                                   style="padding-bottom:200px")
                                 ),
                                 
                                 scrolly_section(id = "Transport Workers",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Some service occupations also experience high risk of exposure")),
                                                 p("High exposure risks are not limited to health and education occupations.",
                                                   span("Delivery couriers",.noWS = "after",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   ",",
                                                   span("bus drivers",.noWS = "after",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   ", and",
                                                   span("uber drivers",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   "are also occupations with higher risks, as are plumbers, public works maintenance workers, and other trades.",
                                                   "Many service occupations are considered essential and many businesses and organizations that employ service workers are maintaining in-person operations, which may put these workers at risk.",
                                                   style="padding-bottom:200px")
                                 ),
                                 scrolly_section(id = "Work From Home",
                                                 label = "Who Can Work From Home?",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Who can't work from home?")),
                                                 p("For some workers, exposure risks can be somewhat mitigated by working from home, reducing exposure on the job as well as while commuting. Using data from the", 
                                                   a("General Social Survey",.noWS = "after",href="https://www23.statcan.gc.ca/imdb/p2SV.pl?Function=getSurvey&SDDS=5221"),
                                                   ", this graph identifies which occupations",
                                                   span("allow workers to work from home",style="font-family:rooneysansmedium !important; color: #14365d"),
                                                   "and which",
                                                   span("do not",.noWS = "after",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   ".",
                                                   span("Security guards",.noWS = "after",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   ",",
                                                   span("cooks",.noWS = "after",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   ", and",
                                                   span("pharmacists",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   "are examples of occupations in which workers report that they are not allowed to work from home.",
                                                   style="padding-bottom:200px")
                                 ),
                                 scrolly_section(id="Work From Home: Focus",
                                                 label = "Who Can Work From Home?",
                                                 div(style="padding-top:45%"),
                                                 p("There are some limitations to the General Social Survey, however, as it only provides data for broad occupational groups, not specific occupations. It also misses some important context on the nature of work in key occupations. For example,", 
                                                   span("home support workers",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   "are classified as an occupation where people can work from home, but workers in this occupation usually work in other people’s homes, providing support services to vulnerable populations.",
                                                   style="padding-bottom:200px")),
                                 
                                 scrolly_section(id="Older Folks",
                                                 label = "Older Folks?",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Older workers")),
                                                 p(a("The Public Health Agency of Canada",href="https://nationalpost.com/health/how-people-over-65-can-do-more-to-protect-themselves-from-covid-19"),
                                                   "notes that individuals aged 65 or above are at an elevated risk of serious complications from COVID-19. This graph highlights occupations where", 
                                                   span("more than 10% of workers are over 65 years old",.noWS = "after",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   ". While many public office holders, including judges and legislators, fall into this category, more than 1/10 workers who drive",
                                                   "buses, subways, taxis, and Ubers are at least 65 years old. Although there are other at-risk populations, including those with pre-existing conditions, we lack the data to tell their story.",
                                                   style="padding-bottom:200px")),
                                 
                                 scrolly_section(id="Second order",
                                                 label = "Older Folks?",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("COVID-19 and Work")),
                                                 p("The impacts of COVID-19 on Canada’s workers do not stop with health risks.",
                                                   "Measures such as physical distancing policies and workplace closures also impact different classes of workers in different ways.",
                                                   "While the federal government has announced important new programs to support workers through this crisis, many are contending with",
                                                   span("income precarity",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   "and",
                                                   span("job security",.noWS = "after",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   ". In the first few weeks since social isolation policies were implemented,",
                                                   a(" almost 1 million Canadian workers filed for Employment Insurance",.noWS = "after",href="https://globalnews.ca/news/6726111/coronavirus-ei-claims-1-million/"),
                                                   ". The federal government anticipates that",
                                                   a("4 million people will apply for the new Canada Emergency Response Benefit",.noWS = "after",href="https://www.theglobeandmail.com/politics/article-trudeau-says-new-merged-benefits-will-help-workers-affected-by-covid/"),
                                                   ". We explore some of the factors that may expose workers to more risk, in the context of labour and economic disruptions.",
                                                   style="padding-bottom:200px")),
                                 
                                 scrolly_section(id="Income Precarity",
                                                 label = "Income Precarity",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Low-income workers")),
                                                 p("This graph highlights",
                                                   span("occupations where 50% of workers are paid less than $32,554",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   "(",
                                                   a("Low Income Cut-off",href="https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1110024101"),
                                                  "for a family of three in urban areas).",
                                                   "Low income workers are more likely to lack savings or assets to smooth income precarity in the case of job loss or reduction of hours.",
                                                   "Many of the same occupations that are more likely to be exposed to disease or infections come up here, including,", 
                                                  span("taxi drivers",.noWS = "after",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                  ",", 
                                                  span("cashiers",.noWS = "after",style="font-family:rooneysansmedium !important; color: #e24585"), 
                                                  ", and", 
                                                  span("sanitation workers",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                  "among many others.",
                                                   style="padding-bottom:200px")),
                                 
                                 scrolly_section(id="Part Time Workers",
                                                 label = "Part Time Workers?",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Part-time workers")),
                                                 p("As businesses shut down, those who hold part-time positions may be among the most precarious, potentially facing a higher risk of having their hours cut as a response to the economic downturn, and in many cases lacking access to employer-provided sick leave.",
                                                   "In 2016, more than 1/2 of workers in Canada worked part time. The",
                                                   span("occupations in magenta",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   "are those in which more than 1/2 of people employed worked on a part-time basis.",
                                                   style="padding-bottom:200px")),
                                 
                                 scrolly_section(id="Visible Minority Workers",
                                                 label = "Where to Visible Minority Workers Work?",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Visible minority workers")),
                                                 p("Finally, other intersectionalities are at play here, including demographics that are more likely to work in higher risk jobs or to have other health conditions.", 
                                                   "For example, occupations where more than",
                                                   span("1/5 of workers belong to a visible minority community",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   "coincide often with occupations highlighted above, where we anticipate higher rates of precarity and in some cases exposure risk.",
                                                   "Visible minority workers also experience higher rates of institutional bias, related or not related to COVID-19.",
                                                   style="padding-bottom:100px"))
                               )
             )),
    fluidRow(class="sectiontitlewrapper",
             style="margin-top:-200px",
             h3("Explore this graph further by searching specific occupations")),
    fluidRow(class="alignedrow",align = "center",
             style="margin:auto; width:50%",
             includeHTML("www/search_icon.html"),
             uiOutput("Occ_choice")),
    fluidRow(align="center",
             style ="margin:auto; width:80%",
             plotlyOutput("finalgraph",width="100%",height="600px")),
    fluidRow(class="sectiontitlewrapper",
             h3("What this all means")),
    fluidRow(class="alignedrow",
            p("As of the date of publication, March 31st, 2020, we are still at the early stages of this pandemic.",
              "There is much we do not know about the disease and how it will impact our economy.",
              "However, we know that many workers are already finding themselves in precarious circumstances.",
              "As this crisis unfolds, the Brookfield Institute is shifting its thinking towards how policymakers can best support the millions of people living in Canada who are being adversely affected.", 
              " If you are interested in working with us, need our help or would like us to highlight work that exists elsewhere, please reach out to us at",
              a("brookfield.institute@ryerson.ca",.noWS = "after",href="mailto:brookfield.institute@ryerson.ca"),
              ".")
            ),
    fluidRow(class="sectiontitlewrapper",
             h3("Information about COVID-19")),
    fluidRow(class="alignedrow",
             div(            p("Current information on COVID-19, including public health recommendations; information on symptoms, diagnosis, and treatment; and the federal government’s COVID-19 Economic Response Plan, can be found on the",
                               a("Government of Canada’s website",.noWS = "after",href="https://www.canada.ca/en/public-health/services/diseases/coronavirus-disease-covid-19.html"),
                               "."),
                             p("For those who have been laid off, are experiencing reduced hours or income, as well as those who have become sick, require self-isolation or quarantine, or are undertaking caregiving duties, income support is available through the Canadian Emergency Response Benefit, expanded access to EI, and support for businesses. More information on these programs can be found",
                               a("on the Government of Canada's website",href="https://www.canada.ca/en/department-finance/economic-response-plan.html"),
                               ". Additional support is offered through provincial and territorial governments."))

    ),
    
    
    fluidRow(class="sectiontitlewrapper",
             h3("About this data visualization")),
    fluidRow(style="font-size:1.1em",p("This data visualization was created by the Brookfield Institute for Innovation and Entrepreneurship, having been inspired by an effort by ",
                                       a("the New York Times",href="https://www.nytimes.com/interactive/2020/03/15/business/economy/coronavirus-worker-risk.html"), ". See the",a(href="https://github.com/BrookfieldIIE/Covid19_Work_Canada_Viz", "source code on GitHub.")),
             p("The data visualization was developed by Viet Vu using R and Shiny."),
             p("This data visualization, would not have been possible without support from the following individuals:
                           Nisa Malli, Sarah Doyle, and Erin Warner."),
             p("The data used in this visualization comes from three sources:",a("O*Net",.noWS = "after",href="https://www.onetonline.org/"),", ",a("General Social Survey",.noWS = "after",href="https://www23.statcan.gc.ca/imdb/p2SV.pl?Function=getSurvey&SDDS=5221"),", and",a("2016 Long Form Canadian Census",.noWS = "after",href="https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/index-eng.cfm"),"."),
             p("Please send any feedback, comments, or questions to", a(href="mailto:brookfield.institute@ryerson.ca",.noWS = "after", "brookfield.institute@ryerson.ca"),"."),
             div(style="margin-top:25px;border-top: 1px solid #e3e3e3",p(style="font-style: italic","For media enquiries, please contact", 
                                                                         a(href="https://brookfieldinstitute.ca/team/coralie-dsouza","Coralie D’Souza"), 
                                                                         "Director of Communications, Events + Community Relations at the 
                                                                                     Brookfield Institute for Innovation + Entrepreneurship."))
             )
    ), #End of the massive div wrapper
    
    fluidRow(style="background: #072b49; margin-left: 0%; margin-right: 0%; font-size: 12px !important; max-width: unset; padding-top:64px; padding-bottom:24px",
             div(class="footer",
                 style = "padding-left: 5%; padding-right: 5%",
                 includeHTML("www/site_footer.html")))
             
    )


# Define server logic required to draw a histogram
server <- function(input, output) {

  output$Occ_choice <- renderUI(
    selectInput("occ",
                label=NULL,
                choice = sort(unique(work.styles.to.plot[,str_sub(noc_title,5)])),
                selected = "Taxi and limousine drivers and chauffeurs",width="600px"))
    output$mainPlot <- renderPlotly({
      if(length(input$scr)==0){
        main.plot()
      }
      else{
        main.plot(triggers=input$scr)
      }
    })
    output$scr <- renderScrollytell({scrollytell()})
    output$section <- renderUI({h3(paste0("Section: ", input$scr),style="margin-bottom:125px")})
    observe({cat("section:", input$scr, "\n")})
    
    output$finalgraph <- renderPlotly({
      final.plot(occupation_focus=input$occ)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
