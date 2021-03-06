% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DDFunctions.R
\name{degree_days}
\alias{degree_days}
\title{Calculate degree days}
\usage{
degree_days(Tmin, Tmax, LDT = NA, UDT = NA, method = "single.sine")
}
\arguments{
\item{Tmin}{Minimum temperature of the day.}

\item{Tmax}{Maximum temperature of the day.}

\item{LDT}{lower developmental threshold.}

\item{UDT}{upper developmental threshold.}

\item{method}{type of method being used. Current choices: "single.sine","double.sine", "single.triangulation" or "double.triangulation".}
}
\description{
Single sine wave approximation from  
Double Sine wave approximation of degree days from Allen 1976 
(see http://www.ipm.ucdavis.edu/WEATHER/ddss_tbl.html)
}
\details{
This function allows you to calculate degree days using single or double sine wave and single or double triangulation approximation.
}
\examples{
\dontrun{
degree_days(7,14,12,33,"single.sine")
degree_days(7,14,12,33,"single.triangulation")
}

}
\keyword{days}
\keyword{degree}
