shinyServer(function(input, output) {
  
  output$text1 <- renderText({ 
    paste("Sie haben folgende Kategorie gewählt:", input$var)
  })
  
}
)