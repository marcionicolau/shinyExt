# libray xtable used in creating the table
# library(xtable)

#' htmlTableHead
#' 
#' @param dataframe A data frame to generate HTML table
#' @param include.rownames Include rownames in generated table?. Default: TRUE
#' 
#' Generate HTML Table Head component
#' @import xtable
htmlTableHead <- function(dataframe,include.rownames=TRUE)
{
  thinfo <- if(include.rownames) c("",names(dataframe)) else names(dataframe)
  paste(c("<thead>", "<tr>", 
          sprintf("<th> %s </th>", thinfo), 
          "</tr>","</thead>"), 
        collapse='\n')
}

htmlTable <- function(dataframe,table_id, align="right",
                      include.rownames=TRUE)
{
  alg = paste(rep(gsub("(.).*","\\1", align),ncol(dataframe)+1),collapse="")
  res = capture.output(print(xtable(dataframe, align=alg), 
                             type='html', 
                             only.contents=TRUE,
                             include.rownames=include.rownames, 
                             include.colnames=FALSE))
  
  tbl = paste(c(sprintf('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="%s">', table_id),
                htmlTableHead(dataframe, include.rownames=include.rownames),
                "<tbody>",
                res,
                "</tbody>",
                "</table>"),
              collapse='\n')
  return(tbl)
}

DataTableScript <- function(table_id) {
  tagList(
    tags$script(sprintf("$('#%s').dataTable({'aaSorting': [[0,'asc']]});",table_id))
    )
}

#' Create a datatable output control
#' 
#' Create an output datatable control for data values
#' 
#' @param table_id Input variable to assign the control's value to
#' @param func A function to process dataset.
#' 
#' @return A datatable output control that can be added to a UI definition.
#' 
#' @examples
#' renderDataTable("tbl_dataset",function() {
#'  if (input$output_selection == 0 || is.null(input$output_selection)) {
#'    count <<- 0 
#'    return(NULL)
#'  }
#'  return(isolate({
#'    if (input$output_selection > 0 & count < input$output_selection) {
#'      count <<- count + 1
#'      if (!is.null(input$tool1_select2)) {
#'        car.idx <- which(rownames(mtcars) %in% input$tool1_select2)
#'        mtcars[car.idx,]
#'      }
#'    }
#'  }))
#'  })
#' 
#' @export
renderDataTable <- function(table_id,func) {
  addResourcePath(
    prefix='shinyExt',
    directoryPath =  system.file('inputExt',
                                 package='shinyExt')
  )
  tagList(
    tags$link(href="shinyExt/css/DT_bootstrap.css",rel="stylesheet",
              type="text/css"),
    tags$script(src="shinyExt/js/DT_bootstrap/jquery.dataTables.min.js",
                type="text/javascript"),
    tags$script(src="shinyExt/js/DT_bootstrap/dataTables.numericCommaSort.js",
                type="text/javascript"),
    tags$script(src="shinyExt/js/DT_bootstrap/dataTables.numericCommaTypeDetect.js",
                type="text/javascript"),
    tags$script(src="shinyExt/js/DT_bootstrap/DT_bootstrap.js",
                type="text/javascript")       
  )
  reactive({
    data <- func()
    if (is.null(data) || is.na(data))
      return(paste(em("Preparing table ...")))
    return(paste(htmlTable(data, 
                           table_id, 
                           include.rownames=TRUE),
                 DataTableScript(table_id),
                 collapse='\n')
    )
  })
}