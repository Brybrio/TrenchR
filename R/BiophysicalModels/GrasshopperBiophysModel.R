#' @details Predicts body temperatures (operative environmental temperature) of a grasshopper in degrees C.
#' @description Predicts body temperature (operative environmental temperature) of a grasshopper in degrees C. Described in Buckleyet al. (2014, Phenotypic clines, energy balances, and ecological responses to climate change. Journal of Animal Ecology 83:41-50.) See also a related model by Anderson et al. (1979, Habitat selection in two species of short-horned grasshoppers. Oecologia 38:359–74.)
#' 
#' @param Ta is air temperature in C
#' @param Tg  is surface temperature in C, Kingsolver (1983) assumes Tg-Ta=8.4
#' @param u is wind speed in m/s
#' @param rad  is total (direct + diffuse) solar radiation flux in W/m^2
#' @param kt is the clearnex index (dimensionless), which is the ratio of the global solar radiation measured at the surface to the total solar radiation at the top of the atmosphere.
#' @param psi is solar zenith angle in degrees
#' @param L in grasshopper length in m
#' @param Acondfact is the proportion of the grasshopper surface area that is in contact with the ground
#' @param z is grasshopper's distance from the ground in m
#' @param abs is absorptivity of grasshopper to solar radiation (proportion), See Anderson et al. (1979).
#' @param r_g is substrate solar reflectivity (proportion), see Kingsolver (1983)
#' 
#' @keywords body temperature, biophysical model
#' @export
#' @examples
#' \dontrun{
#' Tb_grasshopper(Ta=25, Tg=25, u=0.4, rad=400, kt=0.7, psi=30, L=0.02, Acondfact=0.25, z=0.001, abs=0.7, r_g=0.3)
#'}

Tb_grasshopper=function(Ta, Tg, u, rad, kt, psi, L, Acondfact=0.25, z=0.001, abs=0.7, r_g=0.3){
  
TaK<- Ta+273.15 #Ambient temperature in K
Tg<- Tg+273.15 #Ambient temperature in K

#Biophysical parameters
#IR emissivity
omega<-5.66 * 10^-8 # stefan-boltzmann constant (W m^-2 K^-4)
epsilon=1 #Gates 1962 in Kingsolver 1983  #emissivity of surface to longwave IR

Kf=0.025  #Kf=0.024+0.00007*Ta[k] #thermal conductivity of fluid

#kineamatic viscosity of air (m^2/s); http://users.wpi.edu/~ierardi/PDF/air_nu_plot.PDF
v=15.68*10^-6  #m^2/s, kinematic viscocity of air,  at 300K #http://www.engineeringtoolbox.com/air-absolute-kinematic-viscosity-d_601.html

#AREAS
#Samietz (2005): The body of a grasshopper female was approximated by a rotational ellipsoid with half the body length as the semi-major axis q.
#Area from Wolfram math world
c<- L/2 #c- semi-major axis, a- semi-minor axis
a<- (0.365+0.241*L*1000)/1000  #regression in Lactin and Johnson (1988)
e=sqrt(1-a^2/c^2)
A=2*pi*a^2+2*pi*a*c/e*asin(e)

#------------------------------
#SOLAR RADIATIVe HEAT FLUX   
#Separate Total radiation into components
#Use Erbs et al model from Wong and Chow (2001, Applied Energy 69:1991-224)

#kd- diffuse fraction
if(kt<=0.22) kd=1-0.09*kt
if(kt>0.22 & kt<=0.8) kd= 0.9511 -0.1604*kt +4.388*kt^2 -16.638*kt^3 +12.336*kt^4
if(kt>0.8) kd=0.165 #kd = 0.125 #Correction from 16.5 for CO from Olyphant 1984

Httl=rad
Hdir=Httl*(1-kd)
Hdif=Httl*kd;     

#------------------------------
#Anderson 1979 - calculates Radiation as W without area dependence 
psi_r=psi*pi/180 #psi in radians

#Calculate Qabs as W
Qdir=abs*Hdir/cos(psi_r) #direct radiation
Qdif=abs*Hdif #diffuse radiation
Qref= r_g *Httl #reflected radiation
Qabs= Qdir + Qdif + Qref  #W/m2

#------------------------------
#convection

#Reynolds number- ratio of interval viscous forces
#L: Characeristic dimension (length)
# u= windspeed #Lactin and Johnson add 1m/s to account for cooling by passive convection
Re= u*L/v
#Nusselt number- dimensionless conductance
Nu=0.41* Re^0.5 #Anderson 1979 empirical
h_c= Nu *Kf /L # heat transfer coefficient, Wm^{-2}C^{-1} #reported in Lactin and Johnson 1998

hc_s<- h_c *(-0.007*z/L +1.71) # heat transfer coefficient in turbulent air 

#conduction 
Thick= 6*10^(-5) #cuticle thickness (m)
hcut= 0.15 #W m^-1 K^-1
Acond=A * Acondfact 
#Qcond= hcut *Acond *(Tb- (Ta+273))/Thick

#------------------------------
#Energy balance based on Kingsolver (1983, Thermoregulation and flight in Colias butterflies: elevational patterns and mechanistic limitations. Ecology 64: 534–545).

#Thermal radiative flux
#Areas
# silhouette area / total area
sa<-0.19-0.00173*psi #empirical from Anderson 1979, psi in degrees
Adir= A*sa
Aref=Adir 

#Calculate Qabs as W/m2
Qdir=abs*Adir*Hdir/cos(psi_r)
Qdif=abs*Aref*Hdif
Qref= abs* r_g * Aref *Httl
Qabs= Qdir + Qdif + Qref  #W/m2

Tsky=0.0552*(Ta+273.15)^1.5; #Kelvin, black body sky temperature from Swinbank (1963), Kingsolver 1983 estimates using Brunt equation
               
#Qt= 0.5* A * epsilon * omega * (Tb^4 - Tsky^4) +0.5 * A * epsilon * omega * (Tb^4 - Tg^4) 
#Convective heat flux
#Qc= hc_s * A * (Tb- (Ta+273)) 
#Qs= Qt+ Qc

#WITH CONDUCTION
#t solved in wolfram alpha #Solve[a t^4 +b t -d, t]
a<- A * epsilon *omega
b<-hc_s * A + hcut*Acond/Thick
d<- hc_s*A*TaK +0.5*A*epsilon *omega*(Tsky^4+Tg^4)+ hcut *Acond*Tg/Thick +Qabs

#WITHOUT CONDUCTION
#a<- A * epsilon *omega
#b<-hc_s * A
#d<- hc_s*A*TaK +0.5*A*epsilon *omega*Tsky^4 +0.5*A*epsilon *omega*Tg^4 +Qabs

#eb<-function(Tb) 0.5* A * epsilon * omega * (Tb^4 - Tsky^4) +0.5 * A * epsilon * omega * (Tb^4 - Tg^4) + hc_s * A * (Tb-TaK)+hcut *Acond *(Tb-Tg)/Thick -Qabs 
#r <- uniroot(eb, c(-1,373), tol = 1e-5)
#r$root-273

#roots
tb = 1/2*sqrt((2*b)/(a*sqrt((sqrt(3)*sqrt(256*a^3*d^3+27*a^2*b^4)+9*a*b^2)^(1/3)/(2^(1/3)*3^(2/3)*a)-(4*(2/3)^(1/3)*d)/(sqrt(3)*sqrt(256*a^3*d^3+27*a^2*b^4)+9*a*b^2)^(1/3)))-(sqrt(3)*sqrt(256*a^3*d^3+27*a^2*b^4)+9*a*b^2)^(1/3)/(2^(1/3)*3^(2/3)*a)+(4*(2/3)^(1/3)*d)/(sqrt(3)*sqrt(256*a^3*d^3+27*a^2*b^4)+9*a*b^2)^(1/3))-1/2*sqrt((sqrt(3)*sqrt(256*a^3*d^3+27*a^2*b^4)+9*a*b^2)^(1/3)/(2^(1/3)*3^(2/3)*a)-(4*(2/3)^(1/3)*d)/(sqrt(3)*sqrt(256*a^3*d^3+27*a^2*b^4)+9*a*b^2)^(1/3)) 

#convert NaN to NA
tb[which(is.na(tb))]=NA

return(tb-273.15)
}
