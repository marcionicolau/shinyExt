#' Create a spreadsheet input control
#' 
#' Create an input control for input data values
#' 
#' @param inputId Input variable to assign the control's value to
#' @return A sreadsheet input control that can be added to a UI definition.
#' 
#' @details Based on work of [cafe876](https://github.com/cafe876/Shiny-Sandbox.git), [yannrichet](https://github.com/yannrichet/Shiny-Sandbox.git) and [brianbolt](https://github.com/brianbolt/rShinyApps.git).
#' 
#' @examples
#' spreadsheetInput("tbl_dataset")
#' 
#' @export
spreadsheetInput <- function(inputId){
  addResourcePath(
    prefix='shinyExt',
    directoryPath =  system.file('inputExt',
                                 package='shinyExt')
  )
  tagList(
    singleton(tags$head(tags$script(
      src = "http://handsontable.com/jquery.handsontable.js", 
      type='text/javascript'))),
    singleton(tags$head(tags$script(
      src = "http://handsontable.com/lib/bootstrap-typeahead.js", 
      type='text/javascript'))),
    singleton(tags$head(tags$script(
      src = "http://handsontable.com/lib/jQuery-contextMenu/jquery.contextMenu.js", 
      type='text/javascript'))),
    singleton(tags$head(tags$script(
      src = "http://handsontable.com/lib/jQuery-contextMenu/jquery.ui.position.js", 
      type='text/javascript'))),    
    singleton(tags$head(tags$script(
      src = "shinyExt/js/handsonTable.js", 
      type='text/javascript'))),    
    singleton(tags$head(tags$link(
      rel="stylesheet", 
      type="text/css", 
      href="http://handsontable.com/lib/jQuery-contextMenu/jquery.contextMenu.css"))),
    singleton(tags$head(tags$link(
      rel="stylesheet", 
      type="text/css", 
      href="http://handsontable.com/jquery.handsontable.css"))),    
    tags$body(
      tags$div(id=inputId, class="handsonTable-output"),
      br()
    )
  )
}