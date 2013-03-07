\name{spreadsheetInput}
\alias{spreadsheetInput}
\title{Create a spreadsheet input control}
\usage{
  spreadsheetInput(inputId)
}
\arguments{
  \item{inputId}{Input variable to assign the control's
  value to}
}
\value{
  A sreadsheet input control that can be added to a UI
  definition.
}
\description{
  Create an input control for input data values
}
\details{
  Based on work of
  [cafe876](https://github.com/cafe876/Shiny-Sandbox.git),
  [yannrichet](https://github.com/yannrichet/Shiny-Sandbox.git)
  and
  [brianbolt](https://github.com/brianbolt/rShinyApps.git).
}
\examples{
spreadsheetInput("tbl_dataset")
}

