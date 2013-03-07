library(shiny)
library(RJSONIO)
library(plyr)

jsonToList <- function(json) {
  jsonAsList <- fromJSON(json, strict = StrictNumeric + StrictLogical, nullValue = NA)
	return(jsonAsList)
}
jsonToDataFrame <- function(json) {
	if(json=="[]") {
		return(null)
	} else {
		jsonAsList <- jsonToList(json)
		jsonAsDataFrame <- ldply(jsonAsList,function(x) as.data.frame(t(unlist(x)), stringsAsFactors = FALSE))
		return(jsonAsDataFrame)
	}
}
myData <- cars[1:10,]

# Minimal Custom
shinyServer(function(input, output) {
  
  table_data <- reactive({
    input <- input$exampleGrid
    if(input == "[]") {
    	return(myData)
    } else {
    	return(jsonToDataFrame(input))
    }
  })
  output$exampleGrid <- reactive(
  	return(toJSON(as.data.frame(t(table_data())), .withNames=FALSE))
  )
  dataSet <- reactive({
  	dataSet <- table_data()
  	dataSet <- suppressWarnings(as.data.frame(sapply(dataSet, as.numeric)))
  	dataSet <- log(dataSet)
  	return(dataSet)
  })
  output$handsontable <- reactive(
  	toJSON(as.data.frame(t(dataSet())), .withNames=FALSE)
  )
  output$table_text2 <- renderTable({
    dataSet()
  })

})
