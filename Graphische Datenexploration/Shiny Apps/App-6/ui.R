# ui.R
shinyUI(fluidPage(
  titlePanel("BFS-Open-Data Visualisierung - Regionale Altersverteilung"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Erstelle demographische Karten mit Open-Data Informationen des Bundesamtes für Statistik (BFS)"),
      
      selectInput("var", 
                  label = "Wählen Sie eine Altersgruppe",
                  choices = c("Altersgruppe: 0-19", "Altersgruppe: 20-64",
                              "Altersgruppe: 65 plus"),
                  selected = "Altersgruppe: 20-64")
    ),
    
    mainPanel(plotOutput("map"))
  )
))