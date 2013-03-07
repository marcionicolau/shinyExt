library(shiny)

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Shiny Spreadsheet"),
  
  # Sidebar with controls to select a dataset and specify the number
  # of observations to view
  sidebarPanel()
  ,
  
  # Show a summary of the dataset and an HTML table with the requested
  # number of observations
  mainPanel(    
    spreadsheetInput("exampleGrid"),
    spreadsheetInput("handsontable"),
    htmlOutput("table_text2")
  )
))
