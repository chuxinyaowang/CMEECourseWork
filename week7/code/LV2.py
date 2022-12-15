#!/usr/bin/env python3

#packages
import sys


def main(argv):
    import numpy as np
    import scipy as sc
    from scipy import stats
    import matplotlib.pylab as p
    import scipy.integrate as integrate

#DEFINE FUNCTION
    def dCR_dt(pops, t=0):
        R = pops[0]
        C = pops[1]
        dRdt = r * R*(1- R/K) - a * R * C
        dCdt = -z * C + e * a * R * C

        return np.array([dRdt, dCdt])


#assigning parameter
    r = float(sys.argv[1])
    a = float(sys.argv[2])
    z = float(sys.argv[3])
    e = float(sys.argv[4])
    K= 2000
#define time vector from 0,15 in 1000 divisions
    t = np.linspace(0, 1000, 10000)

#initial condition
    R0= 10
    C0= 10
    RC0 = np.array([R0,C0])

#integrate start conditions with fun
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)



#generate figure
    f2 = p.figure()

    p.plot(t,pops[:,0], 'r-',label='Resource density')# Plot
    p.plot(t,pops[:,1], 'b-',label='Consumer density')
    p.grid()
    p.xlabel('Time')
    p.ylabel('Population density')
    p.legend(loc='best')

    p.text(400,11,'r= {}'.format(r),fontsize=8,color='y')
    p.text(800,11,'a= {}'.format(a),fontsize=8,color='y')
    p.text(400,10,'z= {}'.format(z),fontsize=8,color='y')
    p.text(800,10,'e= {}'.format(e),fontsize=8,color='y')

    p.title('Consumer-Resource population dynamics')
    p.show() #to display the figure

    return(f2.savefig('../results/LV2_model.pdf'))

if (__name__ == "__main__"):
    status = main(sys.argv)