% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TempWindProfileFunctions.R
\name{air_temp_profile_neutral}
\alias{air_temp_profile_neutral}
\title{Estimate temperature at a specified height under neutral conditions}
\usage{
air_temp_profile_neutral(T_r, zr, z0, z, T_s)
}
\arguments{
\item{T_r}{is temperature at reference height in degrees C.}

\item{zr}{is initial reference height in m.}

\item{z0}{is surface roughness in m.}

\item{z}{is height to scale to in m.}

\item{T_s}{is surface temperatures in degrees C.}
}
\value{
temperature (degrees C)
}
\description{
This function allows you to calculate temperature (C) at a specified height (m) within a 
boundary layer near the surface.  The velocity profile is the neutral profile described by Sellers (1965). 
Function in equations (2) and (3) of Porter et al. (1973)
}
\details{
Calculates temperature at a specified height under neutral conditions
}
\examples{
\dontrun{
air_temp_profile_neutral(T_r=20, zr=0.1, z0=0.2, z=0.15, T_s=25)
}

}
\keyword{profile}
\keyword{temperature}
