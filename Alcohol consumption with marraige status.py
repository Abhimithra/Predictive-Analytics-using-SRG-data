#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')
import numpy as np


# In[2]:


df= pd.read_excel('Book2.XLSX')


# In[3]:


df.drop('Height (Inches)',axis=1,inplace=True)


# In[4]:


df.dropna(inplace=True)


# In[16]:


X=df[['No, not married and not living with partner','Single', 'Yes, married or living with partner','Domestic beer','Imported Beer','Craft Beer','Sparkling Wine','Red Wine','White Wine','Scotch','Gin','Bourbon','Vodka','Rum','Tequila']]

y = df['POINTS']


# In[17]:


from sklearn.model_selection import train_test_split


# In[18]:


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.4, random_state=101)


# In[19]:


from sklearn.linear_model import LinearRegression
lm = LinearRegression()


# In[20]:


lm.fit(X_train,y_train)


# In[21]:


import statsmodels.api as sm
from statsmodels.sandbox.regression.predstd import wls_prediction_std

model1=sm.OLS(y_train,X_train)

result=model1.fit()

print(result.summary())


# In[ ]:





# In[10]:


dummies=pd.get_dummies(df['Marriage status'])


# In[14]:


df= pd.concat([df,dummies],axis=1)


# In[15]:


df.head()


# In[ ]:




