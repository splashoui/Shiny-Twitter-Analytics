
# Dataset https://www.kaggle.com/sakshigoyal7/credit-card-customers?select=BankChurners.csv

library(shiny)
library(shinythemes)
data(bank)

# Define UI for app that draws a histogram ----
ui = fluidPage(
  theme = shinytheme("flatly"),
 
  
  # App title ----
  titlePanel("Segmentation of Bank Customers by Agen"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 0,
                  max = 50,
                  value = 20,
                  step=5)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "distPlot")
      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  bank = read.csv("BankChurners.csv")

  output$distPlot <- renderPlot({
    
    x    <- bank$Customer_Age
    #summary(is.na(bank$Customer_Age))
    #x    <- na.omit(x) ### since there is no NaN values , no need for this line
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = "darkblue", border = "yellow",
         xlab = "Age", ylab= "Frequency", 
         main = "Histogram of Bank Customers' Age")
    
  })
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
