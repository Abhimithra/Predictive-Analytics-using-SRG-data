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
df.drop('Height (Inches)',axis=1,inplace=True)
df.dropna(inplace=True)


# In[3]:


X=df[['Age','Domestic beer','Imported Beer','Craft Beer','Sparkling Wine','Red Wine','White Wine','Scotch','Gin','Bourbon','Vodka','Rum','Tequila']]

y = df['POINTS']


# In[4]:


from sklearn.model_selection import train_test_split


# In[5]:


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.4, random_state=101)


# In[6]:


from sklearn.linear_model import LinearRegression
lm = LinearRegression()


# In[7]:


lm.fit(X_train,y_train)


# In[8]:


coeff_df = pd.DataFrame(lm.coef_,X.columns,columns=['Coefficient'])
coeff_df


# In[9]:


import statsmodels.api as sm
from statsmodels.sandbox.regression.predstd import wls_prediction_std

model1=sm.OLS(y_train,X_train)

result=model1.fit()

print(result.summary())


# In[ ]:




