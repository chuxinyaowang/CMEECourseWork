import pandas as pd
#import scipy as sc
#import matplotlib.pylab as pl
#import seaborn as sns 
# You might need to install this (e.g., pip install seaborn)


data = pd.read_csv("../data/LogisticGrowthData.csv")
print("Loaded {} columns.".format(len(data.columns.values)))
print(data.columns.values)


pd.read_csv("../data/LogisticGrowthMetaData.csv")
data.head()

print(data.PopBio_units.unique()) #units of the response variable
print(data.Time_units.unique()) #units of the independent variable

data.insert(0, "ID", data.Species + "_" + data.Temp.map(str) + "_" + data.Medium + "_" + data.Citation)
selectdata=data.ID.unique()#units of the independent variable

#save each dataset into a single csv
for i in range(len(selectdata)):
    data_subset = data[data['ID']== str(selectdata[i])]
    data_subset.to_csv('../sandbox/'+str(i+1)+'.csv')
