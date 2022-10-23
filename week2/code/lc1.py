birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 


# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.



#(1)
#Step 1 Latin names
Latin_names=[] #Create a list first
for row in birds:
    for n in row[0:1]:
        Latin_names.append(n)
print('Latin name list:', Latin_names)

#Step 2 Common names
Common_names=[] #Same with step 1
for row in birds:
    for o in row[1:2]:
        Common_names.append(o)
print('Common name list:', Common_names)

#Step 3 mean body masses
Mean_body_masses=[] #Same with Step 1 
for row in birds:
    for p in row[2:3]:
        Mean_body_masses.append(p)
print('Mean body masses:', Mean_body_masses)




#(2)
#Step 1 Latin names

Latin_names_2=[n for row in birds for n in row[0:1]] 
print("Latin names list is: ", Latin_names_2)

#Step 2 Common names

Common_names_2=[n for row in birds for n in row[1:2]]
print("Common names list is: ", Common_names_2)

#Step 3 Mean body masses

Mean_body_masses_2=[n for row in birds for n in row[2:3]]
print("Mean body length is: ", Mean_body_masses_2)