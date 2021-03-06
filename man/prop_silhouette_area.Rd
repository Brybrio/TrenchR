% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllometricFunctions.R
\name{prop_silhouette_area}
\alias{prop_silhouette_area}
\title{Calculate silhouette area}
\usage{
prop_silhouette_area(psi, taxa, raz = 0, posture = "prostrate")
}
\arguments{
\item{psi}{zenith angle in degrees}

\item{taxa}{Which class of organism, current choices: frog, lizard, grasshopper}

\item{raz}{if lizard, relative solar azimuth angle in degrees, the horizontal angle of the sun (0-180 degrees) relative to the head and frontal plane of the lizard}

\item{posture}{if lizard, indicate posture as "prostrate" or "elevated"}
}
\value{
silhouette area as a proportion
}
\description{
Calculate silhouette area
}
\details{
This function allows you to estimate the projected (silhouette) area as a portion of the surface area of the organism. Estimates the projected area as a function of zenith angle.
}
\examples{
\dontrun{
prop_silhouette_area(psi=60, taxa= "frog")
}

}
\keyword{area}
\keyword{silhouette}
