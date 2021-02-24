source('global.R')

####################################
#       User Interface              #
####################################

shinyUI(dashboardPage(
    
    dashboardHeader(title = "Twitter Analytics"),
    dashboardSidebar(
        sidebarMenu(menuItem("Introduction",tabName = "introduction",icon = icon("sign-language")),
                    menuItem("Tweet Stats",tabName = "graphs",icon = icon("chart-line")),
                    menuItem("Graphs",tabName = "stats",icon = icon("chart-bar")),
                    menuItem("Maps",tabName = "heatmap",icon = icon("fire")),
                    menuItem("About Us",tabName = "ab",icon = icon("eye"))
            
        ) #sidebarMenu
    ), #dashboardSidebar
    

    dashboardBody(
        tabItems(
            tabItem(tabName = 'ab',
                    useShinyalert(),   ##Welcome Alert 
                    box(status = "primary",
                        solidHeader = F,
                        collapsible = F,
                        width = 12,
                        fluidRow(column(width = 4, align = "center",htmlOutput("j")),
                                 column(width = 4, align = "center",htmlOutput("m")),
                                 column(width = 4, align = "center",htmlOutput("p"))
                        ),
                        fluidRow(column(width = 4, align = "center", 
                                        img(src="https://www.fundacionfin.es/wp-content/uploads/2020/11/linkedin-logo.png",width=100),
                                        htmlOutput("jk")),
                                 column(width = 4, align = "center",
                                        img(src="https://www.fundacionfin.es/wp-content/uploads/2020/11/linkedin-logo.png",width=100),
                                        htmlOutput("mk")),
                                 column(width = 4, align = "center",
                                        img(src="https://www.fundacionfin.es/wp-content/uploads/2020/11/linkedin-logo.png",width=100),
                                        htmlOutput("pk"))
                        ),
                        fluidRow(column(width = 4, align = "center", 
                                        img(src="https://miro.medium.com/max/719/0*9f5uMrKMjLbzEf7q.png",width=200),
                                        htmlOutput("jjk")),
                                 column(width = 4, align = "center",
                                        img(src="https://miro.medium.com/max/719/0*9f5uMrKMjLbzEf7q.png",width=200),
                                        htmlOutput("mmk")),
                                 column(width = 4, align = "center",
                                        img(src="https://miro.medium.com/max/719/0*9f5uMrKMjLbzEf7q.png",width=200),
                                        htmlOutput("ppk"))
                        ),
                    )
            ), #tabItem1
            
            tabItem(tabName = 'introduction',
                    box(
                        status = "primary",
                        solidHeader = F,
                        collapsible = F,
                        width = 12,
                        fluidRow(column(width = 12, align = "center",
                                        img(src="https://www.bocetos.com/wp-content/uploads/2015/05/twitter-analytics.jpg", width=400))),
                        fluidRow(column(width = 12, htmlOutput('a'))))
                    
            ), #tabItem2
                            
            tabItem(tabName = "graphs",
                    
                    fluidRow(
                        column(4,align = 'center',
                               valueBoxOutput('tweetnumber',
                                              width = 12)
                        ), #row1col1
                        
                        column(6, align = 'center',
                               box(width = NULL, title = 'Datasets', status = 'primary',
                                   align = 'center',
                                   solidHeader = TRUE, collapsible = FALSE,
                                   collapsed = FALSE,
                                   h4(strong('Select a Sport Type')),
                                   uiOutput('datasetopt')
                               )
                        ), #row1col2
                        
                        column(2, align = "center",
                               downloadBttn('downloadData', 
                                            style = 'material-flat',
                                            color = 'primary')
                        ) #row1col3
                    ), #fluidRow1
                    
                    
                    fluidRow(
                        column(12,
                               box( 
                                   background = 'aqua',
                                   width = 12,
                                   solidHeader = T,
                                   status = 'primary',
                                   collapsible = F, 
                                   collapsed = F,
                                   fluidRow(
                                       
                                       column(6,align = 'center',
                                              selectInput('likert', 
                                                          label = 'Sort by popularity:',
                                                          width='65%',
                                                          choices = list('Most-Retweeted',
                                                                         'Most-Favorited',
                                                                         'Most-Interracted')
                                              ) #selectInput
                                       ), #row2col1
                                       
                                       
                                       
                                       column(6, align = 'center',
                                              selectInput('recenttw',
                                                          label='Sort by Date:',
                                                          choices = list('Newest first',
                                                                         'Oldest first'),
                                                          width='55%')
                                       ) #row2col2
                                   ), #Row2
                                   fluidRow(
                                       column(12, align = 'center',
                                              DTOutput('tableTweets')
                                       ) #row3col1
                                   ) #row3
                                   
                               ) #box
                        ),
                        
                    ), #Row3
                    
                    fluidRow(
                        column(12,
                               box( 
                                   background = 'aqua',
                                   width = 12,
                                   solidHeader = T,
                                   status = 'primary',
                                   collapsible = F, 
                                   collapsed = F,
                                   fluidRow(
                                       
                                       column(12,align = 'center',
                                              selectInput('opt', 
                                                          label = 'Sort by :',
                                                          width='65%',
                                                          choices = list('Most-Profilic-User',
                                                                         'Most-Followed-User')
                                              ) #selectInput
                                       ) #row4col1
                                       
                                       
                                       
                                       
                                   ), #Row4
                                   fluidRow(
                                       column(12, align = 'center',
                                              DTOutput('tableTweets2')
                                       ) #row3col1
                                   ) #row3
                                   
                               ) #box
                        ),
                        
                    ) #Row4
                    
                    
                    
            ),
            
            tabItem(tabName = 'stats',
                    
                    fluidRow(column(4,align = 'center',
                                    valueBoxOutput('tweetnumlocal',
                                                   width = 12)
                    ),
                        column(4,align = 'center',
                               valueBoxOutput('cabeza',
                                              width = 12)
                        ),
                    column(4,align = 'center',
                           valueBoxOutput('tweetnumss',
                                          width = 12)
                    )
                    ),
                    fluidRow(
                        column(6,
                               tabBox(title = "By dataset",
                                      width = 12,
                                      tabPanel("Bar plot",
                                               fluidRow(
                                                   column(12,
                                                         fluidRow(
                                                             column(6,
                                                                    radioGroupButtons(
                                                                        inputId = "selectDataSet2",
                                                                        label = "Dataset", 
                                                                        choices = list('NBA','NFL'),
                                                                        status = "primary",
                                                                        justified = TRUE
                                                                    )
                                                             ),
                                                             column(6,
                                                                    sliderInput('colLoc', label = "Nº locations", value = 10, min = 3, max = 20)
                                                             )
                                                         ),
                                                         fluidRow(
                                                             column(12,
                                                                    plotlyOutput("pou")
                                                             )
                                                         )
                                                    )
                                               )
                                      ),
                                      tabPanel("Pie chart",
                                               fluidRow(
                                                   column(12,
                                                          fluidRow(
                                                              column(6,
                                                                     radioGroupButtons(
                                                                         inputId = "selectDataSet3",
                                                                         label = "Dataset", 
                                                                         choices = list('NBA','NFL'),
                                                                         status = "primary",
                                                                         justified = TRUE
                                                                     )
                                                              ),
                                                              column(6,
                                                                     sliderInput('colSour', label = "Nº sources", value = 10, min = 3, max = 20)  
                                                              )
                                                          )
                                                    )
                                               ),fluidRow(
                                                   column(12,
                                                          plotlyOutput("sourc")     
                                                   )
                                               )
                                      )
                                      
                               )
                        ),
                        column(6,
                               box(
                                   title = "Tweets per day: NBA vs NFL", 
                                   width = 12,
                                   solidHeader = T,
                                   status = 'primary',
                                   collapsible = F,
                                   collapsed = F,
                                   fluidRow(
                                       column(12,
                                              plotlyOutput("lines")
                                       )
                                   )
                               )
                        )
                    ),
                        
                    
                    
                    
            ),
            
            tabItem(tabName = 'heatmap',
                    fluidRow(
                        column(12, align = "center",
                               box(title="Seleccionar Dataset",
                                   status ='primary',
                                   solidHeader = TRUE,
                                   collapsible = TRUE,
                                   collapsed = FALSE,
                                   width = 3,
                                   align = "center",
                                   
                                   radioGroupButtons(
                                       inputId = "selectDataSet",
                                       label = "Dataset", 
                                       choices = list('NBA','NFL'),
                                       status = "primary",
                                       justified = TRUE
                                   ), 
                                   actionButton("seleccionaDataSet", label = "Actualizar")
                               )
                               
                               
                        )
                    ),
                    fluidRow(
                        column(6,
                               box(title="HeatMap",
                                   status ='primary',
                                   solidHeader = TRUE,
                                   collapsible = FALSE,
                                   collapsed = FALSE,
                                   width = 12,
                                   
                                   shinycssloaders::withSpinner(leafletOutput('heatOut'))
                               )
                        ), 
                        column(6,
                              box(title="Pins",
                                  status ='primary',
                                  solidHeader = TRUE,
                                  collapsible = TRUE,
                                  collapsed = FALSE,
                                  width = 12,
                                  
                                  shinycssloaders::withSpinner(leafletOutput('pinMapa'))
                              )
                        )
                    ),
                            
            )              
                            
        ) #tabItemsAll
                    

    ) #dashboardbody
)) #dashboardpage , shinyUI
