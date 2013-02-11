\name{pageWithNavbar}
\alias{pageWithNavbar}
\title{Create a page with a top navbar menu and a sidebar}
\usage{
  pageWithNavbar(navbarPanel, sidebarPanel, mainPanel)
}
\arguments{
  \item{navbarPanel}{The \link{navbarPanel} with the
  application title and contents}

  \item{sidebarPanel}{The \link{sidebarPanel} containing
  input controls}

  \item{mainPanel}{The \link{mainPanel} containing outputs}
}
\value{
  A UI defintion that can be passed to the \link{shinyUI}
  function
}
\description{
  Create a Shiny UI that contains a top navbar menu with
  the application title and shiny Application contents, a
  sidebar for input controls, and a main area for output.
}

