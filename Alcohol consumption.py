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


df.head()


# In[4]:


df.drop('Height (Inches)',axis=1,inplace=True)


# In[5]:


df.dropna(inplace=True)


# In[14]:


X=df['alcohol consumption'].values.reshape(-1,1)

y = df['POINTS']


# In[15]:


from sklearn.model_selection import train_test_split


# In[16]:


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.4, random_state=101)


# In[17]:


from sklearn.linear_model import LinearRegression
lm = LinearRegression()


# In[18]:


lm.fit(X_train,y_train)


# In[19]:


print(lm.intercept_)


# In[21]:


predictions = lm.predict(X_test)


# In[22]:


plt.scatter(y_test,predictions)


# In[23]:


sns.distplot((y_test-predictions),bins=50);


# In[24]:


import statsmodels.api as sm
from statsmodels.sandbox.regression.predstd import wls_prediction_std

model1=sm.OLS(y_train,X_train)

result=model1.fit()

print(result.summary())


# In[ ]:




