% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TsoilFunctions.R
\name{soil_temperature_equation}
\alias{soil_temperature_equation}
\title{Function called by soil_temperature_function() to solve equation for soil temperature.}
\usage{
soil_temperature_equation(L, rho_a, c_a, k, V_inst, z, z0, T_inst, T_s)
}
\arguments{
\item{L}{is the Monin-Obukhov length, a measure of the instability of heat flow (see Beckman et al. 1973)}

\item{c_a}{is specific heat of air (J/(kg*K))}

\item{k}{is von Karman's constant}

\item{V_inst}{is instantaneous wind speed in m/s}

\item{z}{is reference height in m}

\item{z0}{is surface roughness in m}

\item{T_inst}{instantaneous air temperature in K}

\item{T_s}{initial soil suface temperature in degrees C}

\item{rho_A}{is density of air in kg m^-3}
}
\description{
Function called by soil_temp_noint to solve equation for soil temperature from Beckman et al. (1973, Thermal Model for Prediction of a Desert Iguana's Daily and Seasonal Behavior).
}
\examples{
\dontrun{
soil_temperature_equation(L=-10, rho_a=1.177, c_a=1006, k=.41, V_inst=0.3, z=1.5, z0=0.02, T_inst=265, T_s=20)
}
}
\author{
Joseph Grigg
}
