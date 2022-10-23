    #Python I

# #List


MyList = [3,2.44,'green',True]
MyList[1]
MyList[0]

#MyList[4] #Not as long as expected!

MyList[2]= 'blue'
MyList
MyList.append('a new item')

%whos
type(MyList)
print(type(MyList))

MyList
del MyList[2]
MyList


#Tuples
FoodWeb=[('a','b'),('a','c'),('b','c'),('c','c')]
Foodweb

FoodWeb=[0]
FoodWeb[0][0]
#FoodWeb[0][0]= "bbb" immutable!!!
FoodWeb[0]=("bbb","ccc")
FoodWeb[0]

a=(1,2,[])
a

a[2].append(1000)
a

a[2].append(1000)
a

a[2].append((100,10))
a

a = (1,2,3)
b = a + (4,5,6)
b

c = b[1:]
c

b = b[1:]
b

a = ("1",2,True)
a
#Tuples can be heterogeneous too!

#Sets
a = [5,6,7,7,7,8,9,9]
b = set(a)
b

c = set([3,4,5,6])
b & c #intersection ^
b | c # union U
b-c # pick uo the different objects that b has c doesn't have
b<=c #to check if objects in c fully appears in b
b>=c

#Dictionaries
GenomeSize = {'Homo sapiens': 3200.0, 'Escherichia coli': 4.6, 'Arabidopsis thaliana': 157.0}
GenomeSize
GenomeSize['Arabidopsis thaliana']
GenomeSize['Saccharomyces cerevisiae'] = 12.1
GenomeSize
GenomeSize['Escherichia coli'] = 4.6
GenomeSize
GenomeSize['Homo sapiens'] = 3201.1
GenomeSize


#Copy mutable objects
a = [1,2,3]
b = a

a.append(4)
print(a)
print(b) #b changes with a

a = [1,2,3]
b = a[:] #shallow copy, but 1 level deeper
a.append(4)
print(a)
print(b) # b =[1,2,3]

a = [[1,2],[3,4]]
b = a[:]
print(a)
print(b) #both changed again

#deep copy
import copy
a = [[1,2],[3,4]]
b = copy.deepcopy(a)
a[0][1]=22
print(a)
print(b)



#Running bocks of code
x=11
for i in range (x): # ':' don't forget
    if i > 3:
        print(i)

for i in range(10):
    print(i)

a = range(10)
a

for i in range(1,6): #1~5
    print(i)

for i in range(2,10,2): #skip odd numbers, print every number+2
    print(i)

#iterator and iterable
my_iterable = [1,2,3]
type(my_iterable)

my_iterator=iter(my_iterable)
type(my_iterator)

next(my_iterator)
next(my_iterator)
next(my_iterator)
next(my_iterator) #once iteration done, the StopIteration appears.


#Functions
def foo(x):
    x *= x #same as x = x*x
    print(x)
    return x

y = foo(2)
y
type(y)

x = 0; y = 2
if x < y:
    print('yes')

if x:
    print('yes')

if x==0:
    print('yes')

if y:
    print('yes')

if y == 2:
    print('yes')

x = True
if x:
    print('yes')


if x == True:
    print('yes')


#Comprehensions
x = [ i for i in range(10)]
print(x)

x=[]
for i in range(10):
    x.append(i)
print(x)

###
x=[i.lower() for i in ["LIST","COMPREHENSIONS","ARE","COOL"]]
print(x)

x=["LIST","COMPREHENSIONS","ARE","COOL"]
for i in range(len(x)):
    x[i] = x[i].lower()
print(x)


x = ["LIST","COMPREHENSIONS","ARE","COOL"]
x_new = []
for i in x: # implicit loop
    x_new.append(i.lower())
print(x_new)

        #nested loop
matrix = [[1,2,3],[4,5,6],[7,8,9]]
flattened_matrix = []
for row in matrix:
    for n in row:
        flattened_matrix.append(n)
print(flattened_matrix)

matrix = [[1,2,3],[4,5,6],[7,8,9]]
flattened_matrix = [n for row in matrix for n in row]
print(flattened_matrix)


words = (["These", "are", "some", "words"])
first_letters = set()
for w in words:
    first_letters.add(w[0])
print(first_letters)

words = (["These", "are", "some", "words"])
first_letters = {w[0] for w in words}
print(first_letters)



######Importance of the return directive

def modify_list_1(some_list):
    print('got', some_list)
    some_list = [1,2,3,4]
    print('set to',some_list)

my_list = [1, 2, 3]

print('before, my_list =', my_list)
modify_list_1(my_list)
print('after, my_list=',my_list)

###use append to modify original list




def modify_list_3(some_list):
    print('got', some_list)
    some_list.append(4) # an actual modification of the list
    print('changed to', some_list)

my_list = [1, 2, 3]

print('before, my_list =', my_list)
modify_list_3(my_list)

print(my_list)  #append takes actual change to original list!!!!




