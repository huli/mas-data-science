library(shiny)
# Hier wird die Funktion definiert, die ein Histogramm zeichnet
shinyServer(function(input, output) {
  
  # Hier steht der Ausdruck, der ein Histogramm zeichnet. Der Ausdruck ist
  # in der renderPlot-Funktion verpackt. Damit weiss shiny, dass die Funktion
  #  1) "interaktiv" ist, d.h. die Funktion soll neue Werte aufnehmen
  #  2) Der Output-Typ ist ein Plot
  
  output$distPlot <- renderPlot({
    x    <- faithful[, 2]  # Old Faithful Geyser data
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # hier wird das Histogramm schliesslich gezeichnet
    hist(x, breaks = bins, col = 'skyblue', border = 'white')
  })
})