library(shiny)
# Definiere eine UI, die ein Histogramm zeichnet
shinyUI(fluidPage(
  
  # Titel der App
  titlePanel("Hello World!"),
  
  # Eine Seitenleiste mit einem Schieberegler, der die Zahl der "bins" festlegt
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Zahl der bins:",
                  min = 5,
                  max = 50,
                  value = 30)
    ),
    
    # Hier wird definiert, dass ein Plot gezeigt werden soll
    mainPanel(
      plotOutput("distPlot")
    )
  )
))