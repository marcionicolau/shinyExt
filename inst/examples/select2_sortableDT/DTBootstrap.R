# libray xtable used in creating the table
library(xtable)

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

reactiveDataTable <- function(table_id,func) 
{
  reactive(function() 
  {
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