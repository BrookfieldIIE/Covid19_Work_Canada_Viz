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
                 p("Thank you for your interest in exploring how Covid-19 might change how Canadians work."),
                 p(" Unfortunately, this interactive data visualization can only be experienced on a larger screen at this time.",
                 " If you are unable to do so, please visit the ",a("accompanying blog post",href="https://brookfieldinstitute.ca/"), " which explores insights from this visualization."))),

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
                               div(p("Covid-19 has rapidly changed what it means for us to be working and living. For many, such impact differs greatly depending on where and how one works.",
                                     " To understand how different workers might be exposed to Covid-19, and impacted by our rapidly changing world, we developed this interactive data visualization, inspired by efforts led by Lazaro Gamio at the ",
                                     a("New York Times", href="https://www.nytimes.com/interactive/2020/03/15/business/economy/coronavirus-worker-risk.html"),
                                     "."),
                                   p("Over time, we intend to add to this visualization, to paint a fuller picture of how Covid-19 will affect economic precarity faced by Canadians.")
                                   )
                               ),
                      fluidRow(style="margin-left:0%; margin-right:0%;font-family: rooneysanslight !important; text-align:center; padding-bottom:0px; border-top:1px solid #14365D",
                               "Scroll down to enjoy this experience. Enjoyed best on a desktop browser."),
                      fluidRow(style="margin-left:0%; margin-right:0%;text-align:center; padding-bottom:0px; padding-top:0px",includeHTML("www/arrow_down.html")),
               scrolly_container("scr"
                               , scrolly_graph( div(style="padding-top:30%"),
                                                plotlyOutput("mainPlot"),
                                                p(style="font-family:rooneysanslight; font-size:11px; padding-left:10%; padding-top:1.5%",img(src="biie_logo.png",style="display:unset; position:unset; height:14px;width:14px"),"Visualization by the Brookfield Institute.")
                                                
                               )
                               , scrolly_sections(
                                 scrolly_section( id = "Introduction",
                                                  label = "Canadians Working From Home",
                                                  div(style="padding-top:45%"),
                                                  div(class="sectiontitlewrapper",h2("Introduction")),
                                                  p("On the right, you can see the key graph we'll explore in this experience. We draw on three data sources to paint this picture:",
                                                    a("O*Net",href="https://www.onetonline.org/"),
                                                    ", ",
                                                    a("General Social Survey",href="https://www23.statcan.gc.ca/imdb/p2SV.pl?Function=getSurvey&SDDS=5221"),
                                                    ", and the",
                                                    a("2016 Long Form Canadian Census",href="https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/index-eng.cfm"),
                                                    " .",
                                                    " These separate datasets were connected using ",a("a crosswalk",href="https://brookfieldinstitute.ca/commentary/connecting-the-dots-linking-canadian-occupations-to-skills-data/"),
                                                    "developed by the Brookfield Institute.",
                                                    style="padding-bottom:200px")
                                 ),
                                 scrolly_section( id = "Introduction2",
                                                  label = "Canadians Working From Home",
                                                  div(style="padding-top:45%"),
                                                  div(class="sectiontitlewrapper",h2("Anatomy of the visualization")),
                                                  p("Each dot in this graph represents an",
                                                    span(" occupation ", style="font-family:rooneysansmedium !important; color: #e24585"),
                                                    " where ",
                                                    span("larger dots", style="font-family:rooneysansmedium !important; color: #e24585"),
                                                    " imply ",
                                                    span("more", style="font-family:rooneysansmedium !important; color: #e24585")
                                                    ," people working in that occupation in Canada.",
                                                    " The bottom axis denotes the ",
                                                    a("physical proximity", href="https://www.onetonline.org/find/descriptor/result/4.C.2.a.3"),
                                                    " the workers have with others; and the lefthand axis denotes the level of",
                                                    a("exposure to disease pathogen",href="https://www.onetonline.org/find/descriptor/result/4.C.2.c.1.b"),
                                                    " a worker experiences in a typical day.",
                                                    style="padding-bottom:200px"),
                                 ),
                                 scrolly_section(id = "Health Workers",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Health workers experience high levels of exposure")),
                                                 p("For example, Health occupations, such as ",
                                                   span("Respiratory therapists",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   " or ",
                                                   span("Dentists",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   " are occupations with high risks of being exposed to Covid-19, where they work in close proximity of patients, and are directly exposed to diseases everyday. It is also worth noting that some specific health occupations, such as Dental services",
                                                   a(" have provided a guidance",href="https://oda.ca/156-you-and-your-dentist/478-covid-19-updates-from-the-oda"),
                                                   " to reschedule all non-emergency procedures.",
                                                   style="padding-bottom:200px")
                                                 ),
                                 
                                 scrolly_section(id = "Education Workers",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Education workers: rapidly changing landscape")),
                                                 p("However, this data reflects work contexts that was the case before the pandemic broke out. Educatiors in",
                                                   span("elementary schools",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   " or ",
                                                   span("universities",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   " are ordinarily high on exposure risk. However, in responding to the pandemic, almost all educational institutions have now shifted to an online model, characterizing how rapidly labour conditions change in response to the crisis.",
                                                   style="padding-bottom:200px")
                                 ),
                                 
                                 scrolly_section(id = "Transport Workers",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Some service occupations also experience high risk of exposure")),
                                                 p("Such exposure risks however, are not limited to health occupations. ",
                                                   span("Delivery couriers",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   ", ",
                                                   span("Bus drivers",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   ",or ",
                                                   span("Uber drivers",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   " are also occupations that face high risk of being exposed to pathogens while working closely with others.",
                                                   " These service occupations are also oftentimes considered essential services, especially in light of physical distancing policies.",
                                                   style="padding-bottom:200px")
                                 ),
                                 scrolly_section(id = "Work From Home",
                                                 label = "Who Can Work From Home?",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Who can't work from home?")),
                                                 p("For some workers, exposure risks can be somewhat mitigated by working from home. Using data from the", 
                                                   a("General Social Survey",href="https://www23.statcan.gc.ca/imdb/p2SV.pl?Function=getSurvey&SDDS=5221"),
                                                   ", we know workers in which occupations ",
                                                   span("can work from home ",style="font-family:rooneysansmedium !important; color: #14365d"),
                                                   "and which ",
                                                   span("can't work from home.",style="font-family:rooneysansmedium !important; color: #e24585"), 
                                                   "Apart from health workers, grocery store clerks and drivers are examples of those who still have to show up regularly to their place of work, increasing their exposure risk.",
                                                   style="padding-bottom:200px")
                                 ),
                                 scrolly_section(id="Work From Home: Focus",
                                                 label = "Who Can Work From Home?",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Working from home: more than meets the eye")),
                                                 p("There are some limitations to the General Social Survey, as it only has data for broad occupational groups, not specific occupations. It also misses some important contexts. Take", 
                                                   span("home care workers",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   "for example: it's classified as an occupation where people can work from home, but obviously, such workers rarely work in their own home, and often work with vulnerable populations, putting not just the workers but their clients at risk.",
                                                   style="padding-bottom:200px")),
                                 
                                 scrolly_section(id="Older Folks",
                                                 label = "Older Folks?",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Older workers")),
                                                 p("From available evidence, we know that those aged 65 or above are at a significantly elevated risk of serious complications resulting from CoVid-19. Here, we've highlighted occupations where ", 
                                                   span("more than 10% of workers are at least 65 years old",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   ". While many public office holders, including judges and legislators fall into this category, more than one in ten workers who drive busses, subways, taxis, and ubers are aged 65 or above.",
                                                   " It is important to note as well, that many more people are at risk, including those who are immunocompromised, but we have a poor understand of labour market activity of these individuals.",
                                                   style="padding-bottom:200px")),
                                 
                                 scrolly_section(id="Second order",
                                                 label = "Older Folks?",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Going further than the disease itself")),
                                                 p("The impact of Covid-19 doesn't neccesarily stop at the disease itself. There are credible reasons to believe that the response to the pandemic itself, namely physical distancing policies and the shut down of workplaces also impact different class of workers.", 
                                                   " Such impact can come in the form of ",
                                                   span("income precarity",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   span("job security",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   ", and others.",
                                                   " We will now explore some such second order impacts.",
                                                   style="padding-bottom:200px")),
                                 
                                 scrolly_section(id="Income Precarity",
                                                 label = "Income Precarity",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Income Precarity")),
                                                 p("In the first weeks since social isolation policy has taken hold in Canada,",
                                                   a(" almost 1 million Canadian workers filed for Employment Insurance",href="https://globalnews.ca/news/6726111/coronavirus-ei-claims-1-million/"),
                                                   ". ",
                                                   span("Workers in occupations where 50% are paid less than the",a(" Low Income Cut-off ",href="https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1110024101"),style="font-family:rooneysansmedium !important; color: #e24585"),
                                                  "for a family of 3 in urban areas, or $32,554",
                                                   " are at an elevated risk of financial precarity.",
                                                   " Many of the same occupations that we've highlighted come up here: taxi drivers and cashiers, amongst others.",
                                                   style="padding-bottom:200px")),
                                 
                                 scrolly_section(id="Part Time Workers",
                                                 label = "Part Time Workers?",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Part Time Workers")),
                                                 p("As businesses shut down as well, those who hold part time positions are perhaps amongst the most precarious: having hours and pay cut down as a response to the economic downturn. In fact, more than half of workers in Canada in 2016 worked part time. And the ",
                                                   span("occupations in magenta ",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   "are those occupations where more than half the people employed worked on a part time basis.",
                                                   style="padding-bottom:200px")),
                                 
                                 scrolly_section(id="Visible Minority Workers",
                                                 label = "Where to Visible Minority Workers Work?",
                                                 div(style="padding-top:45%"),
                                                 div(class="sectiontitlewrapper",h2("Where do Visible Minority Workers Work?")),
                                                 p("Finally, other intersectionalities are at play. We explore visible minority as an example here, as Covid-19 has also increased incidences of xeonophobia, directed a specific populations in the economy.", 
                                                   span("home care workers",style="font-family:rooneysansmedium !important; color: #e24585"),
                                                   "for example: it's classified as an occupation that people can work from home, but obviously, such workers are still at a high risk of exposure, given that they work with vulnerable populations. ",
                                                   style="padding-bottom:100px"))
                               )
             )),
    fluidRow(class="sectiontitlewrapper",
             style="margin-top:-200px",
             h3("Explore this graph further by searching and highlighting specific occupations")),
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
            p("As of March 24th, 2020, we are still at an early stages of this pandemic. There are much we still don't know about the disease and how it will impact our economy.",
              " However, we know that many workers are already finding themselves in precarious circumstances.", 
              " As this crisis unfolds," ,
              a("we commit",href="https://brookfieldinstitute.ca/commentary/a-message-from-our-executive-director-sean-mullin/"),
              "to conducting relevant research to inform policies that ensure all of Canada, workers and non workers alike, can weather this storm.")
            ),
    fluidRow(class="sectiontitlewrapper",
             h3("Information about Covid-19")),
    fluidRow(class="alignedrow",
            p("Current information on COVID-19, including public health recommendations; information on symptoms, diagnosis, and treatment; and the federal government’s COVID-19 Economic Response Plan, can be found on the ",
              a("Government of Canada’s website",href="https://www.canada.ca/en/public-health/services/diseases/coronavirus-disease-covid-19.html"),
              ".")
    ),
    fluidRow(class="alignedrow",
             p("For those who have been laid off, are experiencing reduced hours or income, as well as those who have become sick, require self-isolation or quarantine, or are undertaking caregiving duties, additional income support will be available through the federal government’s Emergency Support Benefit, and expanded access to EI. More information on these programs can be found ",
               a("here",href="https://www.canada.ca/en/department-finance/economic-response-plan.html"),
               ". Additional supports are offered through many provincial governments.")),
    
    
    fluidRow(class="sectiontitlewrapper",
             h3("About This Data Visualization")),
    fluidRow(style="font-size:1.1em",p("This data visualization was created by the Brookfield Institute for Innovation and Entrepreneurship, having been inspired by an effort by ",
                                       a("the New York Times",href="https://www.nytimes.com/interactive/2020/03/15/business/economy/coronavirus-worker-risk.html"), ". See the",a(href="https://github.com/BrookfieldIIE/sotw-2018-dataviz", "source code on GitHub.")),
             p("The data visualization was developed by Viet Vu using R and Shiny."),
             p("This data visualization, would not have been possible without support from the following individuals:
                           Nisa Malli, Sarah Doyle, and Erin Warner."),
             p("The data used in this visualization comes from three sources:",a("O*Net",href="https://www.onetonline.org/"),", ",a("General Social Survey",href="https://www23.statcan.gc.ca/imdb/p2SV.pl?Function=getSurvey&SDDS=5221"),", and ",a("2016 Long Form Canadian Census",href="https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/index-eng.cfm"),"."),
             p("Please send any feedback, comments, or questions to", a(href="mailto:brookfield.institute@ryerson.ca", "brookfield.institute@ryerson.ca")),
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
