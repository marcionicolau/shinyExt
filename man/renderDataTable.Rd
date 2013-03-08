\name{renderDataTable}
\alias{renderDataTable}
\title{Create a datatable output control}
\usage{
  renderDataTable(table_id, func)
}
\arguments{
  \item{table_id}{Input variable to assign the control's
  value to}

  \item{func}{A function to process dataset.}
}
\value{
  A datatable output control that can be added to a UI
  definition.
}
\description{
  Create an output datatable control for data values
}
\examples{
renderDataTable("tbl_dataset",function() {
 if (input$output_selection == 0 || is.null(input$output_selection)) {
   count <<- 0
   return(NULL)
 }
 return(isolate({
   if (input$output_selection > 0 & count < input$output_selection) {
     count <<- count + 1
     if (!is.null(input$tool1_select2)) {
       car.idx <- which(rownames(mtcars) \%in\% input$tool1_select2)
       mtcars[car.idx,]
     }
   }
 }))
 })
}

