import numpy as np
import scipy as sc
from scipy import stats
import matplotlib.pylab as p
import scipy.integrate as integrate


a= np.array(range(5))
a
print(type(a))

print(type(a[0]))

a = np.array(range(5),float)
a
a.dtype #check type

x = np.arange(5)
x

x = np.arange(5.)
x

x.shape

b = np.array([i for i in range(10) if i % 2 == 1])
b

c = b.tolist()
c

mat = np.array([[0,1],[2,3]])
mat.shape #[row,column]


mat[1]
mat[:,1] #second column
mat[0,0]
mat[1,0] #second row first column
mat[0,1]
mat[0,-1]# last column
mat[-1,0]
mat[0,-2]


#Replacing, adding or deleting elements
mat[0,0] = -1
mat

mat[:,0] = [12,12] # replace whole column
mat

np.append(mat, [[12,12]], axis = 0)
np.append(mat, [[12],[12]], axis = 1) #append column

newRow= [[12,12]]
mat = np.append(mat, newRow, axis = 0)
mat

np.delete(mat, 2, 0) #delete 3rd row
#?np.delete

mat = np.array([[0,1],[2,3]])
mat0= np.array([[0,10],[1,-3]])
np.concatenate((mat,mat0), axis = 0)


mat.ravel()
mat.reshape((4,1))

mat.reshape((1,4))
#mat.reshape((3, 1))


np.ones((4,2))
np.zeros((4,2))
m = np.identity(4)
m
#?np.identity

m.fill(16) #fill with 16
m

mm = np.arange(16)
mm = mm.reshape(4,4)
mm.transpose()

mm + mm.transpose()

mm - mm.transpose()

mm * mm.transpose()

mm // mm.transpose()

mm // (mm +1).transpose()

mm * np.pi

mm.dot(mm)

mm= np.matrix(mm)
mm
print(type(mm))

mm * mm

#scipy stats
sc.stats.norm.rvs(size=10)

np.random.seed(1234)
sc.stats.norm.rvs(size = 10)

sc.stats.norm.rvs(size=5, random_state=1234)



sc.stats.randint.rvs(0,10, size=7)
sc.stats.randint.rvs(0, 10, size = 7, random_state=1234)
sc.stats.randint.rvs(0, 10, size = 7, random_state=1235)

y = np.array([5, 20, 18, 19, 18, 7, 4])
p.plot(y)
p.show()

area = integrate.trapz(y, dx = 3)
print("area =",area)

area = integrate.simps(y, dx = 3)
print("area =", area)


def dCR_dt(pops, t=0):
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C
    dCdt = -z * C + e * a * R * C

    return np.array([dRdt, dCdt])

type(dCR_dt)

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
pops
infodict.keys()

infodict['message']

f1 = p.figure()

p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')
p.show()# To display the figure

f1.savefig('../results/LV_model.pdf')



##practical
f2 = p.figure()

p.plot(pops[:,0],pops[:,1], 'r-') # Plot
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')
p.show()# To display the figure

f2.savefig('../results/LV_model.pdf')

