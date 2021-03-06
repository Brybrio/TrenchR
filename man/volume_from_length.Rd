% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllometricFunctions.R
\name{volume_from_length}
\alias{volume_from_length}
\title{Calculate volume from length (Based on Mitchell 1976)}
\usage{
volume_from_length(length, taxa)
}
\arguments{
\item{length}{in meters.}

\item{taxa}{Which class of organism, current choices: lizard,frog, or sphere}
}
\value{
sa (m^2)
}
\description{
Calculate volume from length (Based on Mitchell 1976)
}
\details{
This function allows you to estimate volume (m^3) from length(m) for a variety of taxa by approximating animal shape as a sphere. The function is intended for use in estimating convection as in Mitchell (1976).
}
\examples{
 \dontrun{
  volume_from_length(.05,"lizard")
}

}
\keyword{area}
\keyword{length}
\keyword{surface}
