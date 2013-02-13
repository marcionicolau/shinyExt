shinyUI(

  pageWithSidebar(

    headerPanel('Select2 and DT_Bootstrap'),

    sidebarPanel(

      br(),
      selectInput("num_cyl", "Number of Cylinders:",
                  as.list(unique(mtcars$cyl))),
      br(),
      uiOutput("tool1s"),
      br(),
      actionButton("output_selection","Show Selections")
      
    ),
    
    mainPanel(
      conditionalPanel(
        condition = "input.output_selection > 0",
        tagList(
          tags$link(href="css/DT_bootstrap.css",rel="stylesheet",type="text/css"),
          tags$script(src="js/jquery.dataTables.js",type="text/javascript"),
          tags$script(src="js/dataTables.numericCommaSort.js",type="text/javascript"),
          tags$script(src="js/dataTables.numericCommaTypeDetect.js",type="text/javascript"),
          tags$script(src="js/DT_bootstrap.js",type="text/javascript"),
          tableOutput("tool1_result")
        )
      )
    )
  )
)