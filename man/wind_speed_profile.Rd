% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TempWindProfileFunctions.R
\name{wind_speed_profile}
\alias{wind_speed_profile}
\title{Estimate wind speed profile as in NicheMapR.}
\usage{
wind_speed_profile(u_r, zr, z0, z)
}
\arguments{
\item{u_r}{is wind velocity at reference height in m/s.}

\item{zr}{is initial reference height in m.}

\item{z0}{is surface roughness in m.}

\item{z}{is height to scale to in m.}
}
\value{
wind speed (m/s)
}
\description{
This function allows you to estimate wind speed (m/s) at a specified height (m).  
Estimates a single, unsegmented wind velocity using the MICRO routine from NicheMapR as described in Kearney and Porter 2016.
Adapted from Kearney and Porter 2016. NicheMapR – an R package for biophysical modelling: the microclimate model
Section 5. Vertical air temperature and wind speed profiles, p11
}
\details{
Calculates wind speed at a specified height
}
\examples{
\dontrun{
wind_speed_profile(u_r=0.1, zr=0.1, z0=0.2, z=0.15)
}
}
\keyword{profile}
\keyword{wind}
