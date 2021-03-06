#' Estimate temperature across hours using a diurnal temperature variation function incorporating sine and exponential componenT_s 
#'

#' @details This function allows you to estimate temperature across hours using a diurnal temperature variation function incorporating sine and exponential componenT_s as in Parton and Logan (1981).
#' @param T_max maximum daily temperature (C)
#' @param T_min minimum daily temperature (C)
#' @param t_s time of sunrise (hour)
#' @param t_r time of sunset (hour)
#' @param t hour for temperature estimate
#' @param alpha  time difference between t_x(time of maximum temperature) and noon
#' @param gamma decay parameter for rate of t change from sunset to t_n(time of minimum temp)
#' @param beta time difference between t_x and sunrise
#' @keywords Temperature
#' @export
#' @examples
#' \donT_run{
#' Thour.sineexp()
#' }

#Function to calculate Parton and Logan 1981 diurnal variation
#Parameters for Colorado
#alpha=1.86
#gamma=2.20
#beta= -0.17

#Wann 1985
#alpha= 2.59 #time difference between T_x and noon
#beta= 1.55 #time difference between T_x and sunrise
#gamma= 2.2 #decay parameter for rate of t change from sunset to T_n

#PAtterson 1981 function from Wann 1985
diurnal_temp_variation_sineexp=function(T_max, T_min, t, t_r, t_s, alpha=2.59, beta= 1.55, gamma=2.2){
#T_max= max temperature
#T_min= min temperature
#t= hour of measurement (0-24)

l= t_s-t_r #daylength
  
#alpha, beta, gamma parameterizations
#Wann 1985
# Average of 5 North Carolina sites: alpha=2.59, beta= 1.55, gamma=2.2
#Parton and Logan 1981, parameterized for Denver, CO  
# 150cm air temeprature: alpha=1.86, beta= 2.20, gamma=-0.17
# 10cm air temperature: alpha=1.52, beta= 2.00, gamma=-0.18
# soil surface temperature: alpha=0.50, beta= 1.81, gamma=0.49
# 10cm soil temperature: alpha=0.45, beta= 2.28, gamma=1.83


T_x= 0.5*(t_r+t_s)+alpha #time of maximum temperature
T_n= t_r+ beta #time of minimum temperature

#calculate temperature for nighttime hour
if(!(t > (t_r + beta) & t < t_s)) {
  T_sn = T_min + (T_max - T_min) * sin((pi * (t_s - t_r - beta)) / (l + 2 * (alpha -
                                                                      beta)))
  if (t <= (t_r + beta))
    Tas = t + 24 - t_s
  if (t >= t_s)
    Tas = t - t_s  #time after sunset
  T = T_min + (T_sn - T_min) * exp(-(gamma * Tas) / (24 - l + beta))
}

#calculate temperature for daytime hour
if(t>(t_r + beta) &
   t<t_s) {
  T = T_min + (T_max - T_min) * sin((pi * (t - t_r - beta)) / (l + 2 * (alpha -
                                                                    beta)))
}
return(T)
}

#----------------------------------------

#' Diurnal temperature across hours
#' From Campbell and Norman 1998 - Uses sine interpolation
#'
#' @details This function allows you to estimate temperature for a specified hour using the sine interpolation in Campbell and Norman (1998).
#' @param T_max maximum daily temperature in degree celsius 
#' @param T_min minimum daily temperature in degree celsius
#' @param t hour for temperature estimate
#' @keywords Temperature
#' @export
#' @examples
#' \dontrun{
#' diurnal_temp_variation_sine(T_max=30, T_min=10, t=11)
#' }


diurnal_temp_variation_sine=function(T_max, T_min, t){
  #T_max= max temperature
  #T_min= min temperature
  
  W=pi/12;
  gamma= 0.44 - 0.46* sin(0.9 + W * t)+ 0.11 * sin(0.9 + 2 * W * t);   # (2.2) diurnal temperature function
  T = T_max-T_min * (1-gamma);
  
  return(T)
}

#----------------------------------------

#' Estimates temperature across hours
#' From Cesaraccio et al 2001 
#'
#' @details This function allows you to estimate temperature for a specified hour using sine and square root functions (Cesaraccio et al 2001).
#' 
#' @param t hour or hours for temperature estimate
#' @param tr sunrise hour (0-23)
#' @param ts sunset hour (0-23)
#' @param T_max maximum temperature of current day (C) 
#' @param T_min minimum temperature of current day (C)
#' @param Tmn_p minimum temperature of following day (C)
#' @keywords Temperature
#' @export
#' @examples
#' \dontrun{
#' diurnal_temp_variation_sinesqrt( t=8, tr=6, ts=18, T_max=30, T_min=20, Tmn_p=22)
#' }

diurnal_temp_variation_sinesqrt=function(t, tr, ts, T_max, T_min, Tmn_p){
 
  #Time estimates
  tp = tr + 24 #sunrise time following day
  tx= ts - 4 #Assume time of maximum temperature 4h before sunset
  
  #Temperature at sunset
  c=0.39 #empircally fitted parameter
  To= T_max - c*(T_max-T_min_p)
  
  alpha= T_max -T_min
  R = T_max - To
  b= (Tmn_p - To)/sqrt(tp -ts)
  
  T= rep(NA, length(t))
  
  inds=which(t<= tr) 
  if(length(inds>0))  T[inds]= To+b*sqrt(Hr[inds]-(ts-24) )
  
  inds=which(t>tr & t<=tx) 
  if(length(inds>0)) T[inds]= Tmn+ alpha*sin(pi/2*(t[inds]-tr)/(tx-tr))
  
  inds=which(t>tx & t<ts) 
  if(length(inds>0)) T[inds]= To+ R*sin(pi/2*(1+ (t[inds]-tx)/4) )
  
  inds=which(t>=ts) 
  if(length(inds>0))  T[inds]= To+b*sqrt(t[inds]-ts)
  
  return(T)
}
