#' Create a password input control
#' 
#' Create an input control for entry of password values
#' 
#' @param inputId Input variable to assign the control's value to
#' @param label Display label for the control
#' @return A password input control that can be added to a UI definition.
#' 
#' @examples
#' passwordInput("passwd", "Password:")
#' 
#' @import shiny 
#' @export
passwordInput <- function(inputId, label) {
  addResourcePath(
    prefix='shinyExt',
    directoryPath =  system.file('inputExt',
                                 package='shinyExt')
    )
  tagList(
    singleton(tags$head(tags$script(src = 'shinyExt/js/inputExt.js'))),
    tags$label(label),
    tags$input(id = inputId, type="password", value="")
  )
}

#' Action button
#' 
#' Creates an action button whose value is initially zero, and increments by one
#' each time it is pressed.
#' 
#' @param inputId Specifies the input slot that will be used to access the 
#'   value.
#' @param label The contents of the button--usually a text label, but you could
#'   also use any other HTML, like an image.
#'   
#' @export
actionButton <- function(inputId, label) {
  addResourcePath(
    prefix='shinyExt', 
    directoryPath=system.file('inputExt', 
                              package='shinyExt'))
  tagList(
    singleton(tags$head(tags$script(src = 'shinyExt/js/inputExt.js'))),
    tags$button(id=inputId, type="button", class="btn action-button", label)
  )
}

#' Date Range Picker
#' 
#' Creates a dropdown menu from which a user can select a range of dates.
#' This is based on https://github.com/dangrossman/bootstrap-daterangepicker.
#' 
#' @seealso [bootstrap-daterangepicker](https://github.com/dangrossman/bootstrap-daterangepicker) 
#' 
#' @param inputId Specifies the input slot that will be used to access the 
#'  value.
#' @param label The contents of the button--usually a text label, but you could
#'   also use any other HTML, like an image.
#'   
#' @export
daterangePicker <- function(inputId, label) {
  addResourcePath(
    prefix='shinyExt', 
    directoryPath=system.file('inputExt', 
                              package='shinyExt'))
  tagList(
    singleton(tags$head(tags$script(src = 'shinyExt/js/inputExt.js'),
                        tags$script(src = 'shinyExt/js/date.js'),
                        tags$script(src = 'shinyExt/js/daterangepicker.js'),
                        tags$link(rel = "stylesheet", type = "text/css",
                                  href = 'shinyExt/css/daterangepicker.css'),
                        tags$script(src = 'shinyExt/js/jquery-common.js'))),
    tags$label(label),
    tags$input(id = inputId, type="text", value="", name ="daterange-picker")
  )
}

#' Bootstrap Date Picker
#' 
#' Creates a dropdown menu from which a user can select a date.
#' This is based on https://github.com/eternicode/bootstrap-datepicker.
#' 
#' @seealso [bootstrap-datepicker](https://github.com/eternicode/bootstrap-datepicker) 
#' 
#' @param inputId Specifies the input slot that will be used to access the 
#'  value.
#' @param label The contents of the button--usually a text label, but you could
#'   also use any other HTML, like an image.
#' @param default Default date value, if empty Sys.Date() is used.
#' @param format Date format, if empty "dd-mm-yyyy" is used.
#'   
#' @export
datePicker <- function(inputId, label, default=Sys.Date(),
  format="dd-mm-yyyy") {
  addResourcePath(
    prefix='shinyExt', 
    directoryPath=system.file('inputExt', 
                              package='shinyExt'))
  tagList(
    singleton(tags$head(tags$script(src = 'shinyExt/js/inputExt.js'),
                        tags$script(src = 'shinyExt/js/bootstrap-datepicker.js'),
                        tags$link(rel = "stylesheet", type = "text/css",
                                  href = 'shinyExt/css/datepicker.css'),
                        tags$script(src = 'shinyExt/js/jquery-common.js'))),
    tags$label(label),
    tags$input(id = inputId, type="text", 
               value=default, 
               name ="bootstrap-date-picker",
               'data-date-format'=format)
  )
}

#' Create a top navbar input panel
#' 
#' Create an input control for a top navigation bar menu panel
#' 
#' @param inputId Input variable to assign the control's value to
#' @return A navbar menu that can be added to a UI definition.
#' 
#' @export
navbarPanel <- function(inputId) {
#   addResourcePath(
#     prefix='shinyExt',
#     directoryPath =  system.file('inputExt',
#                                  package='shinyExt')
#   )
  tagList(
    singleton(tags$head(tags$script(src = 'shinyExt/js/navbarBinding.js'))),
    div(id = inputId, class="navbar",
      div(class="navbar-inner",
        a(class="brand", href="#", "Title"),
               tags$ul(class="nav",
                  tags$li(class="active", 
                    a(href="#", "Home")),
                  tags$li(tags$a(id="mnu-001", href="#", "Link 1")),
                  tags$li(tags$a(id="mnu-002", href="#", "Link 2"))))
             )
  )
}


#' Create a page with a top navbar menu and a sidebar
#'
#' Create a Shiny UI that contains a top navbar menu with the application title and 
#' shiny Application contents, a sidebar for input controls, and a main area 
#' for output.
#'
#' @param navbarPanel The \link{navbarPanel} with the application title and contents
#' @param sidebarPanel The \link{sidebarPanel} containing input controls
#' @param mainPanel The \link{mainPanel} containing outputs
#' @return A UI defintion that can be passed to the \link{shinyUI} function
#'
#'
#' @export
pageWithNavbar <- function(navbarPanel, sidebarPanel, mainPanel) {
  
  bootstrapPage(
    # basic application container divs
    div(
      class="container-fluid",
      div(class="row-fluid",
          navbarPanel
      ),
      div(class="row-fluid",
          sidebarPanel,
          mainPanel
      )
    )
  )
}