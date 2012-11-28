library(shiny)
library(datasets)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {

  # By declaring databaseInput as a reactive function we ensure that:
  #
  #  1) It is only called when the inputs it depends on changes
  #  2) The computation and result are shared by all the callers (it 
  #     only executes a single time)
  #  3) When the inputs change and the function is re-executed, the
  #     new result is compared to the previous result; if the two are
  #     identical, then the callers are not notified
  #
  datasetInput <- reactive(function() {
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  
  # The output$caption is computed based on a reactive function that
  # returns input$caption. When the user changes the "caption" field:
  #
  #  1) This function is automatically called to recompute the output 
  #  2) The new caption is pushed back to the browser for re-display
  # 
  # Note that because the data-oriented reactive functions below don't 
  # depend on input$caption, those functions are NOT called when 
  # input$caption changes.
  output$caption <- reactiveText(function() {
    input$caption
  })
  
  output$pwd <- reactiveText(function() {
    input$passwd
  })
  
  output$filter_date2 <- reactiveText(function() {
    info <- input$input_period
    dates <- unlist(strsplit(info, ' - '))
    sprintf("You select a window from %s to %s", dates[1], dates[2])
  })
  
  # The output$summary depends on the datasetInput reactive function, 
  # so will be re-executed whenever datasetInput is re-executed 
  # (i.e. whenever the input$dataset changes)
  output$summary <- reactivePrint(function() {
    dataset <- datasetInput()
    summary(dataset)
  })
  
  # The output$view depends on both the databaseInput reactive function
  # and input$obs, so will be re-executed whenever input$dataset or 
  # input$obs is changed. 
  output$view <- reactiveTable(function() {
    head(datasetInput(), n = input$obs)
  })
  
  output$plot <- reactivePlot(function() {
    input$btn_newSample
    n = 100 * input$obs
    hist(rnorm(n))
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste('data-', Sys.Date(), '.csv', sep='')
    },
    content = function(con) {
      write.csv2(head(datasetInput(), n = input$obs), 
                 con, 
                 row.names=FALSE)
    }
  )
})
