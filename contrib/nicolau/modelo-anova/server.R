library(shiny)
# shiny::runApp('~/rtut/damshiny')
library(car)
library(tools)
library(foreign)
library(ggplot2)
library(xlsx)

# avoid breaks in R-output print, don't show error messages in Rstudio
options(width = 200, show.error.messages = FALSE, warn = -1)
# options(width = 200)

loaddata <- function(state) {
  inFile <- state$upload
  if (is.null(inFile))
    return(NULL)

  filename <- inFile$name
  ext <- file_ext(filename)
  file <- newdata <- sub(paste(".",ext,sep = ""),"",filename)
  ext <- tolower(ext)
  if(ext == 'rda' || ext == 'rdata') {
    newdata <- load(inFile$datapath, envir = .GlobalEnv)
  }
  # by putting this here we get the name of the object inside the R data file
  data_sets <<- unique(c(newdata,data_sets))

  if(ext == 'sav') {
    assign(file, read.spss(inFile$datapath), envir = .GlobalEnv)
  } else if(ext == 'dta') {
    assign(file, read.dta(inFile$datapath), envir = .GlobalEnv)
  } else if(ext == 'csv') {
    assign(file, read.csv(inFile$datapath, header = TRUE), envir = .GlobalEnv)
  } else if(ext == 'xls' || ext == 'xlsx') {
    assign(file, read.xlsx(inFile$datapath, 1), envir = .GlobalEnv)
  }
}

# needed since dataView is one of the tools
summary.dataView <- plot.dataView <- extra.dataView <- function(state) {
  NULL
}

# needed since vizualize is one of the tools
summary.vizualize <- function(state) {
  if(is.null(state)) 
    return(cat("Please select a Y-variable\n"))
  return(cat("Plots are shown in the plot-tab\n"))
}

plot.vizualize <- function(state) {
  if(is.null(state)) 
    return(NULL)
  dat <- get(state$dataset)
  if(is.null(state$var2)) {
    print(ggplot(dat, aes_string(x=state$var1)) + geom_histogram())
  } else {
    print(ggplot(dat, aes_string(x=state$var1, y=state$var2)) + geom_point() + geom_smooth(method = "loess", size = 1.5))
  }
}

extra.vizualize <- function(state) {
  NULL
}

summary.dataView <- extra.dataView <- plot.dataView <- function(state) {
  NULL
}

main.regression <- function(state) {
  formula <- paste(state$var1, "~", paste(state$var2, collapse = " + "))
  lm(formula, data = get(state$dataset))
}

# summary.regression <- function(state) {
summary.regression <- function(state) {
  if(is.null(state)) 
    return(cat("Please select one or more independent variables\n"))
  summary(state)
}

plot.regression <- function(state) {
  if(is.null(state)) 
    return(NULL)
  par(mfrow = c(2,2))
  plot(state, ask = FALSE)
}

extra.regression <- function(state) {
  if(is.null(state)) 
    return(NULL)
  if(length(state$coefficients) > 2) {
    cat("Variance Inflation Factors\n")
    VIF <- sort(vif(state), decreasing = TRUE)
    data.frame(VIF)
  } else {
    cat("Insufficient number of independent variables selected to calculate VIF scores\n")
  }
}

summary.compareMeans <- function(state) {
  if(is.null(state$var2) || is.null(state$var1)) 
    return(cat("Please select one or more variables\n"))
  formula <- as.formula(paste(state$var2, "~", paste(state$var1, collapse=" + ")))
  summary(aov(formula, data = get(state$dataset)))
}

plot.compareMeans <- function(state) {
  if(is.null(state$var2)) 
    return(NULL)
  dat <- get(state$dataset)
  print(qplot(factor(dat[,state$var1]), dat[,state$var2], data = dat, xlab = state$var1, ylab = state$var2, geom = c("boxplot", "jitter")))
  # print(ggplot(dat, aes_string(x=state$var1, y=state$var2)) + geom_boxplot()) # x must be specified as a factor --> doesn't work with aes_string
}

extra.compareMeans <- function(state) {
  NULL
}

# initial list of files to play with
data_sets <- c("mtcars", "morley", "rock")

# Labels for variable selectors
labels1 <- c("X-variable", "Dependent variable","Dependent variable")
labels2 <- c("Y-variable", "Independent variables","Variables")
labtools <- c("vizualize", "regression", "compareMeans")
names(labels1) <- names(labels2) <- labtools

# Define server logic 
shinyServer(function(input, output) {

  varnames <- reactive(function() {
    dat <- get(input$dataset)
    colnames <- names(dat)
    names(colnames) <- paste(colnames, " (", sapply(dat,class), ")", sep = "")
    return(colnames)
  })

  output$dataloaded <- reactiveUI(function() {
    # adding 'input$loaded' means the function gets called when input$upload changes
    # by putting it in this function the list of data also gets updated
    input$upload
    loaddata(as.list(input))

    # Drop-down selection of data set
    selectInput(inputId = "dataset", label = "Data sets", choices = data_sets, selected = data_sets[1], multiple = FALSE)
  })

  output$rowsToShow <- reactiveUI(function() {
    # number of observations to show in data view
    nrRow <- dim(get(input$dataset))[1]
    sliderInput("nrRows", "# of rows to show:", min = 1, max = nrRow, value = min(15,nrRow), step = 1)
  })

  # variable selection
  output$var1 <- reactiveUI(function() {
    selectInput(inputId = "var1", label = labels1[input$tool], choices = varnames(), selected = NULL, multiple = TRUE)
  })

  # variable selection
  output$var2 <- reactiveUI(function() {
    selectInput(inputId = "var2", label = labels2[input$tool], choices = varnames()[-which(varnames() == input$var1)], selected = NULL, multiple = TRUE)
  })

  output$choose_columns <- reactiveUI(function() {
    # Get the data set with the appropriate name
    # Create a group of checkboxes and select them all by default
    checkboxGroupInput("columns", "Choose columns", choices  = as.list(varnames()), selected = names(varnames()))
    # selectInput("columns", "Choose columns", choices  = colnames, selected = colnames, multiple = TRUE)
  })
 
  output$data <- reactiveTable(function() {
    dat <- get(input$dataset)[, input$columns, drop = FALSE]
    head(dat, input$nrRows)
  })

  # Analysis reactives

  vizualize <- reactive(function() {
    # calling a reactive several times is more efficient than call a regular function several time
    # if(is.null(input$var2)) 
      # return(NULL)
    as.list(input)
  })

  regression <- reactive(function() {
    # calling a reactive several times is more efficient than call a regular function several time
    if(is.null(input$var2)) 
      return(NULL)
    main.regression(as.list(input))
  })

  compareMeans <- reactive(function() {
    # calling a reactive several times is more efficient than call a regular function several time
    if(is.null(input$var2)) 
      return(NULL)
    as.list(input)
  })

  # Generate output for the summary tab
  output$summary <- reactivePrint(function() {
    f <- get(paste("summary",input$tool,sep = '.'))
    f(get(input$tool)())
  })

  output$plots <- reactivePlot(function() {
    f <- get(paste("plot",input$tool,sep = '.'))
    f(get(input$tool)())
  }, width=600, height=600)

  # Generate output for the correlation tab
  output$extra <- reactivePrint(function() {

    print(as.list(input))

    f <- get(paste("extra",input$tool,sep = '.'))
    f(get(input$tool)())
  })
})