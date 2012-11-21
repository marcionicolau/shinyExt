shinyUI(pageWithSidebar(
  headerPanel("Action button example"),
  sidebarPanel(
    passwordInput("passwd1", "Password:"),
    actionButton("button1", "New samples")
  ),
  mainPanel(
    plotOutput("plot")
  )
))