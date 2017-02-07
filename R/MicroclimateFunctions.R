#TEMPLATE FOR FUNCTIONS
#' Partition radiation into direct, diffuse, and reflected components using models from Campbell & Norman 1988 
#'
#' This function allows you to Partition radiation into direct, diffuse, and reflected components
#' @param psi zenith angle in radians
#' @param elev Elevation (m)
#' @param J Julian Day
#' @param rho albedo (%)
#' @param tau transmissivity (%)
#' 
#' @keywords radiation
#' @export
#' @examples
#' radiation()

#=============================================================
#FUNCTIONS TO ADD
#t_sn is local standard time of true solar noon

#EXTRATERRESTRIAL RADIATION
#J is Julian day
#lat is latitude
#t_d is local standard time of day

w= 2*pi/365
E= 0.01675 #eccentricity of earth's orbit

#ecliptic longitude of the earth in its orbit
e.long= w*(d-80)+2*E*(sin(w*J)-sin(w*80) )

#sd is solar declination #latitude on earth where sun is directly overhead on a given day
sd=arcsin(0.39784993*sin(e.long))

#h is solar hour angle
h=15*(t_d-t_sn)
#P3: solar angle at sunset and sunrise?

et.radiation=function(J,lat ){
  
  a_r2= 1+2*E*cos(w*d)
  cosZ= cos(lat)*cos(sd*h)+ sin(lat)*sin(sd)
  
  #Wavelength-specific irradience reaching plane perpendicular to sun's rays at outer edge of atosphere
  I_wavelength= S_wavelength*a_r2*cosZ
}

#TERRESTRIAL RADIATION

#Z_a is apparent zenith angle, angle between beams of direct radiation and local zenith direction (i.e., vertical) at the surface of the earth
#elev is elevation above sea level

#m(Za) is relative optical air mass
m_Za=sec(Z_a) #for Z_a<80 degrees
m_Za= (cos(Z_a)+0.025*exp(-11*cos(Z_a)) )^{-1} #for 80<Z_a<90 

#wavelength_Th is total monochromatic extinction coefficient
wavelength_Th= #! FIX
  
  #direct, horizontal plane component of terrestrial solar radiation
  I_wavelength= S_wavelength*a_r2*cos(Z_a)*exp(-m_Za*wavelength_Th )

#2.2.2 scattered component of terrestrial radiation
F_d #From Dave and Furakawa (1967) p7 from SOLRAD
F_d_Q

D_wavelength #wavelengths >360 nanometers #! FIX
D_wavelength #wavelengths <= nanometers #! FIX

#Global terestrial radiation
G_wavelength= (I_wavelength + D_wavelength) *wavelength 

#2.3 Slope, aspect and hill-shade effects

#Azimuth of the sun
#Southern hemisphere
if(lat>=0) AZ_sun= arccos((sin(lat)*sin(90*pi/180-Z)-sin(sd))/(cos(lat)*cos(90*pi/180-Z) ) )
#Northern hemisphere
if(lat<0) AZ_sun= arccos(sin(sd)-(sin(lat)*sin(90*pi/180-Z))/(cos(lat)*cos(90*pi/180-Z) ) )
#value ranges from 0-180, subtract from 360 to obtain afternoon angles
if(h>12) AZ_sun= 360 - AZ_sun

#Zenith angle based angle of the slope SL
Z_SL= arccos( cos(Z)*cos(S*L)+sin(Z)*sin(S*L)*cos(AZ_sun-AZ_SL)  )

#P8. Adjustments for cloud cover
#Pcloud is percentage cloud cover
Qsolar_cloud= Q_solar*(0.36+0.64*(1-Pcloud)/100 )

#3. LONGWAVE RADIATION
omega= #Stefan-Boltzmann constant, Wm^{-2}K^{-4}
  emissivity
#T is object's temperature in Kelvin

#Longwave radiation from clear skies
#T_A is shaded air temperture at reference height (i.e., 1.2m) 
#e_A is vapour pressure of air in kPA (see section 5)
#Pcloud is percentage cloud cover
emissivity_sky= 1.72*(e_A/T_A)^(1/7)

#Longwave radiation from clear skies
A_rad= omega*emissivity_sky*(T_A+273)^4*(1-Pcloud/100)
#Cloud longwave radiation
emissivity_cloud=1
C_rad= omega*emissivity_cloud*(T_A-2+273)^4*(CLD/100)
#Total radiation from sky 
Shd=0 percentage shade from vegetation or other objects
Q_IR.sky= (A_rad+C_rad)*(1-Shd/100)
#Total infra-red radiation from shading
Q_IR.veg= C_rad*Shd/100
#Radiation from hill-shade
Q_IR.hill
#Radiation from ground
Q_IR.ground
#Net longwave radiation gain for substrate heat budget
Q_IR=(Q_IR.sky+Q_IR.veg)


Q_IR= omega * emissivity * T^4

