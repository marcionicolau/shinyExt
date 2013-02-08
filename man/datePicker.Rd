\name{datePicker}
\alias{datePicker}
\title{Bootstrap Date Picker}
\usage{
  datePicker(inputId, label, default = Sys.Date(),
    format = "dd-mm-yyyy")
}
\arguments{
  \item{inputId}{Specifies the input slot that will be used
  to access the value.}

  \item{label}{The contents of the button--usually a text
  label, but you could also use any other HTML, like an
  image.}

  \item{default}{Default date value, if empty Sys.Date() is
  used.}

  \item{format}{Date format, if empty "dd-mm-yyyy" is
  used.}
}
\description{
  Creates a dropdown menu from which a user can select a
  date. This is based on
  https://github.com/eternicode/bootstrap-datepicker.
}
\seealso{
  [bootstrap-datepicker](https://github.com/eternicode/bootstrap-datepicker)
}

