#Loops vs. list comprehension

iters = 1000000
import timeit
from profileme import my_squares as my_squares_loops
from profileme2 import my_squares as my_squares_lc


#loops vs. the join method for strings

mystring = "my string"
from profileme import my_join as my_join_join
from profileme2 import my_join as my_join
