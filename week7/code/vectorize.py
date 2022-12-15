def loop_product(a,b):
    N = len(a)
    c = np.zeros(N)
    for i in range(N):
        c[i] = a[i]*b[i]
    return c

def vect_product(a,b):
    return np.multiply(a,b)