library(shiny)

toolChoices <- list("Data view" = "dataView", 
                    "Visualize" = "vizualize", 
                    "Regression" = "regression", 
                    "Compare means" = "compareMeans")
# toolChoices <- list("Visualize" = "vizualize", "Data view" = "dataView", "Regression" = "regression", "Compare means" = "compareMeans")

# Define UI for Data Analysis Menu using Shiny
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Data Analysis Menu in Shiny"),
    
    sidebarPanel(
      wellPanel(
        selectInput(inputId = "tool", label = "Tool:", choices = toolChoices, selected = 'dataView'),
        uiOutput("dataloaded")
      ),

      conditionalPanel(condition = "input.tool == 'dataView'",
        wellPanel(
          fileInput("upload", "Load data (Rdata, CSV, Spss, Stata or Microsoft Excel format)"),
          uiOutput("rowsToShow"),
          uiOutput("choose_columns")
        )
      ),

      conditionalPanel(condition = "input.tool != 'dataView'",
        wellPanel(uiOutput("var1")),
        wellPanel(uiOutput("var2"))
      )
    ),
    
    mainPanel(
      conditionalPanel(condition = "input.tool == 'dataView'", tableOutput("data")),
      conditionalPanel(condition = "input.tool != 'dataView'",
        tabsetPanel(
          tabPanel("Summary", verbatimTextOutput("summary")), 
          tabPanel("Plots", plotOutput("plots", height = 1200)),
          tabPanel("Extra", verbatimTextOutput("extra")) 
        )
      )
    )
  )
)