import cProfile
prof=cProfile.Profile()

def ProfLV1():
    #prof.enable()
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

    #f2.savefig('../results/LV1_model.pdf')
    #prof.disable()

    return 0







def ProfLV2():
    #prof.enable()
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
    r = 1
    a = 0.1
    z = 0.75
    e = 0.5
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
    #p.show() #to display the figure
    #f2.savefig('../results/LV2_model.pdf')
    #prof.disable()
    return 0




import time
start = time.time()
ProfLV1()
print(f"LV1 takes {time.time() - start}s to run.")

start = time.time()
ProfLV2()
print(f"LV2 takes {time.time() - start}s to run.")