% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RadiationPartitioningFunctions.R
\name{partition_solar_radiation}
\alias{partition_solar_radiation}
\title{Estimate the diffuse fraction (k_d) for partitioning solar radiation}
\usage{
partition_solar_radiation(method, kt, lat = NA, sol.elev = NA)
}
\arguments{
\item{method}{to use for estimating the diffuse fraction, currently available: "Liu_Jordan", "Orgill_Hollands", "Erbs", "Olyphant", "Spencer", "Reindl-1", "Reindl-2", "Lam_Li"}

\item{kt}{is the clearness index (dimensionless), which is the ratio of the global solar radiation measured at the surface to the total solar radiation at the top of the atmosphere.}

\item{lat}{is latitude in degrees, needed if method ism Spencer}

\item{sol.elev}{is the solar elevation angles in degrees, needed if method is Reindl-2}
}
\value{
diffuse fraction
}
\description{
This function allows you to partition solar radiation (W m^-2) into direct and diffuse components by estimating the diffuse fraction (k_d) using the models presented in Wong and Chow (2001, Applied Energy 69:1991-224).
}
\details{
Estimate the diffuse fraction (k_d) for partitioning solar radiation (W m^-2) into direct and diffuse components
}
\examples{
\dontrun{
partition_solar_radiation(method="Erbs", kt=0.5, lat=40, sol.elev=60)
}
}
\keyword{radiation}
\keyword{solar}
