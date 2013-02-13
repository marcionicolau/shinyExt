\name{select2Input}
\alias{select2Input}
\title{Simple Select2 Wrapper for selectInput shiny control}
\usage{
  select2Input(inputId, label, choices, selected = NULL,
    multiple = FALSE)
}
\arguments{
  \item{inputId}{Input variable to assign the control's
  value to}

  \item{label}{Display label for the control}

  \item{choices}{List of values to select from}

  \item{selected}{Name of initially selected item (or
  multiple names if multiple = TRUE).}

  \item{multiple}{Is selection of multiple items allowed?}
}
\value{
  A select2 input control that can be added to a UI
  definition.
}
\description{
  Create a Select2 input control. Code is based on
  development from David, Vicent, Joe and others from
  shiny-discuss group
}
\examples{
select2Input("select2_in", "Select:", c("Cylinders" = "cyl",
"Transmission" = "am", "Gears" = "gear"), multiple=FALSE)
}

