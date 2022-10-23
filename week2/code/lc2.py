# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
 
# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

# A good example output is:
#
# Step #1:
# Months and rainfall values when the amount of rain was greater than 100mm:
# [('JAN', 111.4), ('FEB', 126.1), ('AUG', 140.2), ('NOV', 128.4), ('DEC', 142.2)]
# ... etc.

#(1)

#Step #1: List of months and rainfall values when amount of rain was greater than 100mm

greater100mm=[(m,n) for row in rainfall for m in row[0:1] for n in row[1:2] if n > 100]
print('Months and rainfall values when amount of rain was greater than 100mm are:', greater100mm)


#(2)
#Step #1: List of months and rainfall values when amount of rain was less than 50mm

less50mm=[(m,n) for row in rainfall for m in row[0:1] for n in row[1:2] if n < 50]
print('Months that amount of rain was less than 50mm are: ', less50mm)

#(3)
#Step #1

greater100mm_2=[] #Create a list first

for row in rainfall:
    for m in row[1:2]:
        if m > 100:
            greater100mm_2.append(row[0:2])
print('Months and rainfall values when amount of rain was greater than 100mm are: ',greater100mm_2)

#Step #2

less50mm_2=[] #Same as before

for row in rainfall:
    for m in row[1:2]:
        if m < 50:
            less50mm_2.append(row[0:2])
print('Months and rainfall values when amount of rain was less than 50mm are: ',less50mm_2)


