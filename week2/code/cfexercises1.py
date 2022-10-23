#!/usr/bin/env python3

__aurthor__= 'Chuxinyao'
__version__= 1.0

import sys
from xxlimited import foo

def foo_1(x):
    x ** 0.5
    return f"The square root of {x} is {x ** 0.5}"

def foo_2(x, y):
    if x > y:
        return f"{x} is bigger!"
    return f"{y} is bigger!"

def foo_3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
        print(f"the value of x and y get exchanged, now x={x} y={y}")
    if y > z:
        tmp = z
        z = y
        y = tmp
        print(f"the value of y and z get exchanged, now y={y} z={z}")
    return f"List becomes like {[x, y, z]}"


def foo_4(x): # a recursive function that calculates the factorial of x
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return f"The result of factorial of {x} is {result}!"


def foo_5(x): # Calculate the factorial of x in a different way; no if statement involved
    if x == 1:
        return 1
    return x * foo_5(x - 1)
    #return f"The third way! And answer is {x*foo_5(x)}!"



def foo_6(x): 
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return f"The result is still {facto}!"
     

def main(argv):
    print(foo_1(16))

    print(foo_2(1,2))

    print(foo_3(6,5,4))

    print(foo_4(4))

    print(foo_5(4))

    print(foo_6(4))
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)

