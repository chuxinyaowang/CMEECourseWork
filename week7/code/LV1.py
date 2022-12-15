#packages
import numpy as np
import scipy as sc
from scipy import stats
import matplotlib.pylab as p
import scipy.integrate as integrate

#DEFINE FUNCTION
def dCR_dt(pops, t=0):
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C
    dCdt = -z * C + e * a * R * C

    return np.array([dRdt, dCdt])


#assigning parameter
r = 1.
a = 0.1 
z = 1.5
e = 0.75
#define time vector from 0,15 in 1000 divisions
t = np.linspace(0, 15, 1000)

#initial condition
R0= 10
C0= 5
RC0 = np.array([R0,C0])

#integrate start conditions with fun
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)


#generate figure
f2 = p.figure()

p.plot(pops[:,0],pops[:,1], 'r-') # Plot
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')
#p.show() to display the figure

f2.savefig('../results/LV1_model.pdf')


