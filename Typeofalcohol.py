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


# In[28]:


for col in df.columns:
    print(col)


# In[4]:


sum(df['Height (Inches)'].isna())


# In[5]:


df.drop('Height (Inches)',axis=1,inplace=True)


# In[12]:


df.dropna(inplace=True)


# In[13]:


X=df[['Domestic beer','Imported Beer','Craft Beer','Sparkling Wine','Red Wine','White Wine','Scotch','Gin','Bourbon','Vodka','Rum','Tequila']]

y = df['POINTS']


# In[14]:


sum(df['Domestic beer'].isna())


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


# In[20]:


coeff_df = pd.DataFrame(lm.coef_,X.columns,columns=['Coefficient'])
coeff_df


# In[21]:




predictions = lm.predict(X_test)


# In[22]:


plt.scatter(y_test,predictions)


# In[23]:


sns.distplot((y_test-predictions),bins=50);


# In[24]:


from sklearn import metrics


# In[25]:


print('MAE:', metrics.mean_absolute_error(y_test, predictions))
print('MSE:', metrics.mean_squared_error(y_test, predictions))
print('RMSE:', np.sqrt(metrics.mean_squared_error(y_test, predictions)))


# In[27]:


import statsmodels.api as sm
from statsmodels.sandbox.regression.predstd import wls_prediction_std

model1=sm.OLS(y_train,X_train)

result=model1.fit()

print(result.summary())


# In[ ]:




