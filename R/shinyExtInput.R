<<<<<<< HEAD
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
    singleton(tags$head(tags$script(src = 'shinyExt/inputExt.js'))),
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
    singleton(tags$head(tags$script(src = 'shinyExt/inputExt.js'))),
    tags$button(id=inputId, type="button", class="btn action-button", label)
  )
}
=======
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

#' Date Range Piker
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
                        tags$script(src = 'shinyExt/js/jquery-common.js')
#                         tags$script("$(document).ready(function() {
#                                         $('input[name=daterange-picker]').daterangepicker();
#                                     });", type = 'text/javascript')
                        )),
    tags$label(label),
    tags$input(id = inputId, type="text", value="", name ="daterange-picker")
  )
}
>>>>>>> RStudio
