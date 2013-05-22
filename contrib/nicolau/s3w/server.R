


shinyServer(function(input, output) {
  
  # Logging auth process
  output$log_auth <- reactivePrint(function() {
    if(is.null(input$username) || is.null(input$password)) return()
    con <- getpgcon(user=input$username, dbname=input$username, 
                    password=input$password)
    
    dbListTables(con)
  })
  
  
})