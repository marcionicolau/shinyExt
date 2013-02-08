library(shiny)
library(shinyExt)

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Reactivity - Laboratory"),
  
  # Sidebar with controls to provide a caption, select a dataset, and 
  # specify the number of observations to view. Note that changes made
  # to the caption in the textInput control are updated in the output
  # area immediately as you type
  sidebarPanel(
    actionButton("btn_newSample","Generate new sample"),
    textInput("caption", "Caption:", "Data Summary"),
    passwordInput("passwd", "Password:"),
    HTML("<label for='bpassword'>Password 3:</label>",
      "<input type='password' name='bpassword'><br />"),
    
    selectInput("dataset", "Choose a dataset:", 
                choices = c("rock", "pressure", "cars")),
    
    numericInput("obs", "Number of observations to view:", 10),
    
    daterangePicker("input_period", "Select a range period:"),
    
    datePicker("in_date", "Select a date:", default="01-01-2013",
               format="dd/mm/yyyy")
    
  ),
  
  
  # Show the caption, a summary of the dataset and an HTML table with
  # the requested number of observations
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("plot")),
      tabPanel("Summary", 
               h3(textOutput("caption")), 
               br(),
               verbatimTextOutput("summary")
      ),
      tabPanel("Table", 
               downloadLink('downloadData'),
               tableOutput("view")               
      ),
      tabPanel("Secret", 
               textOutput("pwd"),
               br(),
               textOutput("filter_date2"))
    )
  )
))
