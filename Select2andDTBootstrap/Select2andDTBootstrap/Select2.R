# Simple Select2 Wrapper for selectInput shiny control

select2Input <- function(inputId, ...) {
  tagList(
    tags$link(href="css/select2.css",rel="stylesheet",type="text/css"),
    tags$script(src="js/select2.js"),
    selectInput(inputId=inputId, ...),
    tags$script(paste("$(function() { $('#", inputId, "').select2({width:'resolve'}); });", sep=""))
  )
}