% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/energybalance_functions.R
\name{Nu_from_Re}
\alias{Nu_from_Re}
\title{Estimate the Nusselt number from the Reynolds number (based on Mitchell 1976)
(Uses Table 1 which is Convective Heat Trasfer Relations to Animal Shapes)}
\usage{
Nu_from_Re(Re, taxa = "cylinder")
}
\arguments{
\item{Re}{is the Reynolds Number (dimensionless)}

\item{taxa}{Which class of organism, current choices: sphere,cylinder,frog,lizard_traverse_to_air_flow, lizard_parallel_to_air_flow, lizard_surface,lizard_elevated,flyinginsect,spider}
}
\value{
Nusselt number (dimensionless)
}
\description{
Estimate the Nusselt number from the Reynolds number (based on Mitchell 1976)
(Uses Table 1 which is Convective Heat Trasfer Relations to Animal Shapes)
}
\details{
This function allows you to estimate the Nusselt number from the Reynolds number for various taxa (based on Mitchell 1976).
}
\examples{
\dontrun{
Nu_from_Re(Re=5, taxa="cylinder")
}

}
\keyword{Nusselt}
\keyword{number}
