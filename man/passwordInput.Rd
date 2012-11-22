\name{passwordInput}
\alias{passwordInput}
\title{Create a password input control}
\usage{
  passwordInput(inputId, label)
}
\arguments{
  \item{inputId}{Input variable to assign the control's
  value to}

  \item{label}{Display label for the control}
}
\value{
  A password input control that can be added to a UI
  definition.
}
\description{
  Create an input control for entry of password values
}
\examples{
passwordInput("passwd", "Password:")
}

