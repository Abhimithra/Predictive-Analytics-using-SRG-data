#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import numpy.random as nr
import math
from sklearn import preprocessing
import sklearn.model_selection as ms
from sklearn import linear_model
import sklearn.metrics as sklm
import scipy.stats as ss
from sklearn.model_selection import train_test_split
from sklearn.linear_model import SGDRegressor
from sklearn.neighbors import KNeighborsRegressor
from sklearn.preprocessing import MinMaxScaler
from pandas.plotting import scatter_matrix
from sklearn.svm import SVR


# In[2]:


df= pd.read_excel('book.XLSX')


# In[3]:


df.head()


# In[4]:


for col in df.columns:
    print(col)


# In[4]:


df.drop(['Q1ra',
'Q1rb',
'Q1rd',
'Q1re',
'Q1rf',
'Q1rh',
'Q1ri',
'Q1rj',
'Q1rk',
'Q1rm',
'Q1rn',
'Q1ro',
'Q1rp',
'Q1rq',
'Q1rr',
'Q1rs',
'Q1rt',
'hQ1ra',
'hQ1rb',
'hQ1rd',
'hQ1re',
'hQ1rf',
'hQ1rh',
'hQ1ri',
'hQ1rj',
'hQ1rk',
'hQ1rm',
'hQ1rn',
'hQ1ro',
'hQ1rp',
'hQ1rq',
'hQ1rr',
'hQ1rs',
'hQ1rt',
'Q2ra',
'Q2rb',
'hQ2ra',
'hQ2rb',
'Q3ra',
'Q3rb',
'Q3rc',
'hQ3ra',
'hQ3rb',
'hQ3rc',
'Q4',
'hQ4',
'Q5',
'hQ5',
'Q6',
'hQ6'],axis=1,inplace =True)


# In[5]:


df.head()


# In[6]:


for col in df.columns:
    print(col)


# In[12]:


#Q1)


# In[6]:


import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')
import numpy as np


# In[ ]:





# In[6]:


sns.jointplot(x='S3',y='POINTS',data=df,kind='scatter')


# In[7]:


sns.heatmap(df.isnull(),yticklabels=False,cbar=False,cmap='viridis')


# In[11]:


sns.jointplot(x='D3',y='POINTS',data=df,kind='scatter')


# In[12]:


df['hQ11']= df['hQ1ra']+df['hQ1rb']+df['hQ1rd']+df['hQ1re']+df['hQ1rf']+df['hQ1rh']+df['hQ1ri']+df['hQ1rj']+df['hQ1rk']+df['hQ1rm']+df['hQ1rn']+df['hQ1ro']+df['hQ1rp']+df['hQ1rq']+df['hQ1rr']+df['hQ1rs']+df['hQ1rt']


# In[13]:


df['hQ22']=df['hQ2ra']+df['hQ2ra']


# In[12]:


df['hQ33']=df['hQ3ra']+df['hQ3rb']


# In[13]:


df[['hQ11','hQ22','hQ33','hQ4','hQ5','hQ6','POINTS']]


# In[14]:


df['psy']= df['hQ11']+df['hQ22']+df['hQ33']


# In[15]:


df['phy']= df['hQ4']+df['hQ6']


# In[26]:


X= df[['hQ11','hQ22','hQ33']]
y= df['phy']


# In[28]:


sns.jointplot(x='psy',y='phy',data=df,kind='scatter')


# In[32]:


sns.lmplot(x='psy',y='phy',data=df,hue='S2')


# In[ ]:


X = df[['h',]]
y = df['POINTS']


# In[33]:


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.4, random_state=101)


# In[34]:


from sklearn.linear_model import LinearRegression


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[56]:


X_train_org, X_test_org, y_train, y_test = train_test_split(X, y, random_state = 0, test_size = 0.2)

scaler = MinMaxScaler()
X_train = scaler.fit_transform(X_train_org)
X_test = scaler.transform(X_test_org)


# In[57]:


X_train


# In[58]:


from sklearn.neighbors import KNeighborsClassifier

train_score_array = []
test_score_array = []

for k in range(1,20):
    knn = KNeighborsClassifier(k)
    knn.fit(X_train, y_train)
    train_score_array.append(knn.score(X_train, y_train))
    test_score_array.append(knn.score(X_test, y_test))


# In[59]:


x_axis = range(1,20)
get_ipython().run_line_magic('matplotlib', 'inline')
plt.plot(x_axis, train_score_array, label = 'Train Score', c = 'g')
plt.plot(x_axis, test_score_array, label = 'Test Score', c='b')
plt.xlabel('k')
plt.ylabel('Accuracy')
plt.legend()


# In[66]:


knn = KNeighborsClassifier(12)
knn.fit(X_train, y_train)
print('Train score: {:.4f}'.format(knn.score(X_train, y_train)))
print('Train score: {:.4f}'.format(knn.score(X_test, y_test)))


# In[67]:



from mlxtend.plotting import plot_decision_regions

X_b = X_train[100:150,:]
y_b = y_train[100:150]

knn = KNeighborsClassifier(10)
knn.fit(X_b, y_b) 

plot_decision_regions(X_b, y_b, clf = knn)


# In[ ]:





# In[ ]:





# In[ ]:




