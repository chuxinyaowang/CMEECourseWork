taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a python script to populate a dictionary called taxa_dic derived from
# taxa so that it maps order names to sets of taxa and prints it to screen.
# 
# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc. OR, 'Chiroptera': {'Myotis
#  lucifugus'} ... etc

#### Your solution here ####

#create four lists to store all specices names
Chi=[]
Rod=[]
Afr=[]
Car=[]
#create a list to store 4 genus names
keys=[]
for row in taxa:
        for n in row[0:1]:
                for o in row[1:2]:
                        if o == 'Chiroptera':
                                Chi.append(n)
                                keys.insert(0,'Chiroptera')
#Here, use insert can make sure each genus name can be matched  with correct species name
                        if o == 'Rodentia':
                                Rod.append(n)
                                keys.insert(1,'Rodentia')
                        if o == 'Afrosoricida':
                                Afr.append(n)
                                keys.insert(2,'Afrosoricida')
                        if o == 'Carnivora':
                                Car.append(n)
                                keys.insert(3,'Carnivora')

values=[]
values.append(Chi)
values.append(Rod)
values.append(Afr)
values.append(Car)
#combine genus names and spices names into a dictionary 
taxa_dic=dict(zip(keys,values))
taxa_dic
# Now write a list comprehension that does the same (including the printing after the dictionary has been created)  
 
#### Your solution here ####
taxa_dic={}
taxa_dic1={}
taxa_dic2={}
taxa_dic3={}
taxa_dic4={}
taxa_dic1['Chiroptera']=[m for row in taxa for m in row[0:1] for n in row [1:2] if n == 'Chiroptera']
taxa_dic2['Rodentia']=[m for row in taxa for m in row[0:1] for n in row [1:2] if n == 'Rodentia']
taxa_dic3['Afrosoricida']=[m for row in taxa for m in row[0:1] for n in row [1:2] if n == 'Afrosoricida']
taxa_dic4['Carnivora']=[m for row in taxa for m in row[0:1] for n in row [1:2] if n == 'Carnivora']
# Merge contents of dict3, dict2 and dict1 to dict4 by using '**'
taxa_dic={**taxa_dic1, **taxa_dic2, **taxa_dic3, **taxa_dic4}
print('The dictionary is: ', taxa_dic)
