


shinyServer(function(input, output) {
    
  shinyalert("Welcome", "Welcome to the Twitter Analytics Shiny Dashboard!", type = "info" , confirmButtonCol = '#1DA1F2',animation= TRUE)
  
  output$a = renderText({ paste ("The purpose of this shiny application is to analyze the datasets 
  about <b> NBA and NFL </b> which are obtained from <b> twitter</b> by using <b>twitter api</b> by library <b> rtweet </b> .")}) 
  
  
######################GRAPHS###############
  
  
  #REACTIVES ----
  
  selpop <- reactive({
    
    cols = input$colLoc
    
    if (input$selectDataSet2 == "NBA"){
      
      table = table(nba$Location)
      data = as.data.frame(table)
      
      data %>% arrange(desc(Freq))
      topnbaLoc = head(data %>% arrange(desc(Freq)), cols+1)
      
      topnbaLoc[1,] = NA
      topnbaLoc = na.omit(topnbaLoc)
      
      colnames(topnbaLoc) <- c("Location","Tweets")
      top = topnbaLoc
      
    } else {
      
      table = table(nfl$Location)
      data = as.data.frame(table)
      
      data %>% arrange(desc(Freq))
      topnflLoc = head(data %>% arrange(desc(Freq)), cols+1)
      topnflLoc[1,] = NA
      topnflLoc = na.omit(topnflLoc)
      
      colnames(topnflLoc) <- c("Location","Tweets")
      
      top = topnflLoc
    
    }
    
    top
    
  })#Reactive Location
  
  
  selsource <- reactive({

    cols = input$colSour
    
    if (input$selectDataSet3 == "NBA"){
      
      table = as.data.frame(table(nba$source))
      
      topnbaSour = head(table %>% arrange(desc(Freq)), cols)
      
      print(table)
      
      others_val = sum(table$Freq)-sum(topnbaSour$Freq)
      others = data.frame("Others",others_val)
      colnames(others) = c('Var1','Freq')
      
      source <- rbind(topnbaSour,others)
      
      colnames(source) <- c("Source","Tweets")
      source
      
    } else {
      
      table = as.data.frame(table(nfl$source))
      
      topnflSour = head(table %>% arrange(desc(Freq)), cols)
      print(table)
      print(topnflSour)
      
      others_val2 = sum(table$Freq)-sum(topnflSour$Freq)
      others2 = data.frame("Others",others_val2)
      colnames(others2) = c('Var1','Freq')
      
      source <- rbind(topnflSour,others2)
      
      colnames(source) <- c("Source","Tweets")
      source
      
    }

    source

  })#reactive SSOO
  
  
  selLines <- reactive({
    
    dates_nba = as.data.frame(table(nba$Date))
    dates_nfl = as.data.frame(table(nfl$Date))
    
    colnames(dates_nba) <- c("DateNBA","TweetsNBA")
    colnames(dates_nfl) <- c("DateNFL","TweetsNFL")
    
    tres = data.frame(format(as.Date("2021-02-03", format= "%Y-%m-%d")),0)
    colnames(tres) = c("DateNFL","TweetsNFL")
    cuatro = data.frame(format(as.Date("2021-02-04", format= "%Y-%m-%d")),0)
    colnames(cuatro) = c("DateNFL","TweetsNFL")
    cinco = data.frame(format(as.Date("2021-02-05", format= "%Y-%m-%d")),0)
    colnames(cinco) = c("DateNFL","TweetsNFL")
    seis = data.frame(format(as.Date("2021-02-06", format= "%Y-%m-%d")),0)
    colnames(seis) = c("DateNFL","TweetsNFL")
    siete = data.frame(format(as.Date("2021-02-07", format= "%Y-%m-%d")),0)
    colnames(siete) = c("DateNFL","TweetsNFL")
    
    dates_nfl <- rbind(dates_nfl,tres)
    dates_nfl <- rbind(dates_nfl,cuatro)
    dates_nfl <- rbind(dates_nfl,cinco)
    dates_nfl <- rbind(dates_nfl,seis)
    dates_nfl <- rbind(dates_nfl,siete)
    
    dates = cbind(dates_nba, dates_nfl)
    
    dates
    
  })
  
  
  selDatasetDT <- reactive({
    
    if (input$datasetopt == "NBA"){
      
      totds <- totds %>% dplyr::filter(Sport == "NBA")}
    
    
    else {
      
      totds <-totds %>% dplyr::filter(Sport == "NFL")
    }
    
    totds
    
  })
  
  reactive1 <- reactive({
    
    totds_filtrado = selDatasetDT()
    
    totds_filtrado <- totds_filtrado %>% 
      select(Date, UserID, Tweet, Favorites, 
             Retweets,Interactions)
    
    if (input$recenttw == 'Newest first'){
      totds_filtrado %>% dplyr::arrange(desc(ymd(totds_filtrado$Date)))
    }
    else if (input$recenttw == 'Oldest first'){
      totds_filtrado %>% dplyr::arrange(ymd(totds_filtrado$Date))}
    
    
    if (input$likert == 'Most-Retweeted'){
      
      if (input$recenttw == 'Newest first'){
        totds_filtrado %>% dplyr::arrange(desc(totds_filtrado$Retweets),desc(ymd(totds_filtrado$Date)))
      }
      else if (input$recenttw == 'Oldest first'){
        totds_filtrado %>% dplyr::arrange(desc(totds_filtrado$Retweets),ymd(totds_filtrado$Date))
      }
    }
    
    else if (input$likert == 'Most-Favorited'){
      
      if (input$recenttw == 'Newest first'){
        totds_filtrado %>% dplyr::arrange(desc(totds_filtrado$Favorites),desc(ymd(totds_filtrado$Date)))
      }
      else if (input$recenttw == 'Oldest first'){
        totds_filtrado %>% dplyr::arrange(desc(totds_filtrado$Favorites),ymd(totds_filtrado$Date))
      }
    }
    
    
    else if (input$likert == 'Most-Interracted'){
      
      if (input$recenttw == 'Newest first'){
        totds_filtrado %>% dplyr::arrange(desc(totds_filtrado$Interactions),desc(ymd(totds_filtrado$Date)))
      }
      else if (input$recenttw == 'Oldest first'){
        totds_filtrado %>% dplyr::arrange(desc(totds_filtrado$Interactions),ymd(totds_filtrado$Date))
      }
    }
    
  })

  reactive2 <- reactive({
    
    totds_filtrado = selDatasetDT()
    
    if (input$opt == 'Most-Profilic-User'){
      a <- data.frame(table(totds_filtrado$UserID))
      
      colnames(a) <- c("UserName","Number_of_Tweets")
      
      a %>% arrange(desc(a$Number_of_Tweets))}
    
    else if (input$opt == 'Most-Followed-User'){
      
      b <- totds_filtrado %>% select(UserID,Name,Followers,Location) %>%
        group_by(UserID) %>% arrange(desc(Followers)) %>% top_n(1,Followers)
      
      b[!duplicated(b), ]
    }
    
    
  })
  
  seleccionarDataset <- reactive({
    
    input$seleccionaDataSet
    
    seleccion = isolate(input$selectDataSet)
    
    if (seleccion == "NBA") {
      lat = nba$lat
      lng = nba$lng
    } else {
      lat = nfl$lat
      lng = nfl$lng
    }
    
    coord = cbind(lng, lat)
    coord = na.omit(coord)
    coord = data.frame(coord)
    
    coord
  })
  

  output$tableTweets <- renderDT({
    
    dataset_filtrado = reactive1()
    
    DT::datatable(dataset_filtrado,options = list(searching = FALSE,ordering= FALSE))
    
  })
  
  output$tableTweets2 <- renderDT({
    
    DT::datatable(reactive2(),options = list(searching = FALSE,ordering= FALSE))
    
  })
  

  output$datasetopt <- renderUI({

    radioGroupButtons(
      inputId = "datasetopt",
      label = NULL,
      choices = c("NBA","NFL"),
      status = "primary",
      checkIcon = list(
        yes = icon("ok", 
                   lib = "glyphicon"),
        no = icon("remove",
                  lib = "glyphicon")),
      justified = TRUE
    )   
  
    
  })
  
  
  output$tweetnumber <- renderValueBox({
    
    valor <- nrow(reactive1())
    valueBox(valor,
             subtitle = 'Total Tweets',
             width = 12,
             color = 'aqua',
             icon = icon('twitter')
    ) #valuebox
    
  })
  
  # DOWNLOAD BUTTON DATASET----
  
  output$downloadData <- downloadHandler(
    filename = function() { 
      paste("dataset-practicaFINAL-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(totds, file)
    })
  
  # GRAFICOS DE BARRAS ----
  
  output$pou <- renderPlotly({
    loci <- selpop()
    
    p <- ggplotly(ggplot(data=loci, aes(fill = Location, x=Tweets, y=Location)) +
                  geom_bar(stat="identity", position="stack") +
                  # geom_text(aes(label=), vjust=3, color="white", size=4)+
                  theme_minimal())
    
    p
  })    #PlotLocation
  
  
  output$sourc <- renderPlotly({
    loci <- selsource()
    
    # Con Ggplot
    # bp<- ggplot(loci, aes(x="", y=Tweets, fill=Source))+
    #   geom_bar(width = 1, stat = "identity")
    # pie <- bp + coord_polar("y", start=0)
    # pie
    
    fig <- plot_ly(loci, labels = ~Source, values = ~Tweets, type = 'pie')
    fig <- fig %>% layout(title = 'Top sources',
                          xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                          yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    fig
    
  })   #plotSSOO
  
  
  output$lines <- renderPlotly({
    
    dates = selLines()
    
    fig <- plot_ly(dates, x = ~DateNBA, y = ~TweetsNBA, name = 'NBA', type = 'scatter', mode = 'lines+markers') 
    fig <- fig %>% add_trace(y = ~dates$TweetsNFL, name = 'NFL', mode = 'lines+markers') 
    
    fig
    
  })
  
  
  output$tweetnumlocal <- renderValueBox({
    
    valor <- nrow(nba)
    valueBox(valor ,
             subtitle = 'Total Tweets NBA',
             width = 12,
             color = 'aqua',
             icon = icon('twitter')
             )
    }) #valuebox
  
  
  output$cabeza <- renderValueBox({
    
    val <- c()
    valueBox(val,
             subtitle = 'Graphics Information',
             width = 12,
             color = 'aqua',
             icon = icon('cogs')
    ) #valuebox
    
  })
  
  output$tweetnumss <- renderValueBox({
    valor <- nrow(nfl)
    valueBox(valor ,
             subtitle = 'Total Tweets NFL',
             width = 12,
             color = 'aqua',
             icon = icon('twitter')
    ) #valuebox
    
  })
  
  # MAPA DE CALOR LEAFLET ----
  
  output$heatOut <- renderLeaflet({
    
    coord = seleccionarDataset()
    
    Sys.sleep(0.5)
    
    leaflet(coord) %>% addTiles() %>%
      addHeatmap(lng = ~lng, lat = ~lat, intensity = 1,
                 blur = 27, max = 0.55, radius = 18) 
    
  })
  
  # MAPA DE PINES LEAFLET ----
  
  output$pinMapa <- renderLeaflet({
    
    coord = seleccionarDataset()
    
    Sys.sleep(0.5)
    
    coord %>% 
      leaflet() %>%
      addTiles() %>%
      addMarkers(clusterOptions = markerClusterOptions())
    
  })
  
  # GRAFICO DE LINEAS PRUEBA ----
  
  eligeLocation <- reactive({
    
    fig <- plot_ly(nba_places_count, x = ~Date)
    if (input$prueba[4] == 'Madrid')
      fig <- fig %>% add_trace(y = ~madrid, name = 'Madrid', mode = 'lines+markers') 
    if (input$prueba[1] == 'Barcelona')
      fig <- fig %>% add_trace(y = ~barcelona, name = 'Barcelona', mode = 'lines+markers')
    if (input$prueba[2] == 'Buenos Aires')
      fig <- fig %>% add_trace(y = ~buenosaires, name = 'Buenos Aires', mode = 'lines+markers')
    if (input$prueba[5] == 'Puerto Rico')
      fig <- fig %>% add_trace(y = ~puertorico, name = 'Puerto Rico', mode = 'lines+markers')
    if (input$prueba[3] == 'Montevideo')
      fig <- fig %>% add_trace(y = ~montevideo, name = 'Montevideo', mode = 'lines+markers')
    
    fig
    
  })
  
  output$graficolineas <- renderPlotly({
    
    ggplotly(eligeLocation())
    
  })

  ###ABOUT US####
  
  
  ##Nombres####
  output$j <- renderText({paste("<b>Jose Antonio Valverde Sánchez </b>")}) 
  
  output$m <- renderText({paste("<b>Mert Kucukkuru </b>")}) 
  
  output$p <- renderText({paste("<b>Francisco Nieves Pastor</b>")})
  
  ###LINKEDIN###
  output$jk <-  renderUI({
    a("Linkedin", href=paste("https://www.linkedin.com/in/jose-antonio-valverde-sánchez-11bab2195/", sep=""),target="_blank")}) 
  
  output$mk <-  renderUI({
    a("Linkedin", href=paste("https://www.linkedin.com/in/mert-küçükkuru-a744321a5/", sep=""), target="_blank")})
  
  output$pk <-  renderUI({
    a("Linkedin", href=paste("https://www.linkedin.com/in/paconp98/", sep=""), target="_blank")})
  
  ########Github####
  output$jjk <-  renderUI({
    a("GitHub", href=paste("https://github.com/", sep=""),target="_blank")}) 
  
  output$mmk <-  renderUI({
    a("GitHub", href=paste("https://github.com/splashoui", sep=""), target="_blank")})
  
  output$ppk <-  renderUI({
    a("GitHub", href=paste("https://github.com/paconp98", sep=""), target="_blank")})  
  
  
  
  

}) ##Shinyserver
