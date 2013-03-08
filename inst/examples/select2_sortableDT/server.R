count <- NULL

shinyServer(function(input, output) {

	output$tool1s <- renderUI({
		select2Input("tool1_select2", label = "Cars:", 
                 choices = switch(input$num_cyl,
                                  "6" = as.list(rownames(mtcars[mtcars$cyl==6,])),
                                  "4" = as.list(rownames(mtcars[mtcars$cyl==4,])),
                                  "8" = as.list(rownames(mtcars[mtcars$cyl==8,]))), 
                 multiple = TRUE)
	})

      
  output$tool1_result <- renderDataTable("tbl_dataset",function() {
    if (input$output_selection == 0 || is.null(input$output_selection)) {
      count <<- 0 
      return(NULL)
    }
    return(isolate({
      if (input$output_selection > 0 & count < input$output_selection) {
        count <<- count + 1
        if (!is.null(input$tool1_select2)) {
          car.idx <- which(rownames(mtcars) %in% input$tool1_select2)
          mtcars[car.idx,]
        }
      }
    }))
  })

})