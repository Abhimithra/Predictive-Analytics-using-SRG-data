#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import seaborn as sns
from sklearn.preprocessing import StandardScaler
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')
import numpy as np


# In[2]:


df= pd.read_excel('Book2.XLSX')


# In[3]:


X=df[['cooking score', 'No sale no shop',
       'save time over food choice in kitchen', 'induldge in food',
       'natural food', 'nat food better for me & envr', 'reward w/ sth tasty',
       'seek out info on health/nutrition',
       'satisfied w/ healthfulness of diet',
       'balance healthy & unhealthy food',
       'give up good taste for healthy food', 'give up convinience for health',
       'buy store brands', 'eat organic', 'no junk food in home',
       'diff types of food', 'fresh food over frozen/canned for cooking',
       'new recipes', 'fam says am good cook',
       'change stores to eat healthier', 'change stores to save money',
       'spend time to find new things in groceries', 'advance meal plans',
       'brands to reflext my style', 'brands to support social causes',
       'follow trends/fashion', 'brands I grew up with', 'price shopper',
       'quality based shopping, not $', 'recommend food I like to others',
       'shopping to relax', 'strive to achieve high social status',
       'wanting to impress others', 'prioritize time w/ fam ',
       'variety in everyday life', 'same life week to week',
       'looking for a thrill', 'consider myself sophisticated',
       'taste over health']]
y=df['POINTS']


# In[4]:


X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=.25,random_state=0)


# In[5]:


from sklearn.linear_model import LinearRegression
lm=LinearRegression()
lm.fit(X_train,y_train)


# In[6]:


import statsmodels.api as sm
from statsmodels.sandbox.regression.predstd import wls_prediction_std
model1=sm.OLS(y_train,X_train)
result=model1.fit()
print(result.summary())


# In[ ]:





# In[ ]:




