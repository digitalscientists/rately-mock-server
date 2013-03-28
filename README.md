Set Up
======

After cloning enter project directory and execute command: `bundle install`.

To start server use command: `bundle exec ruby server.rb`.

Usage
=====

API
---
### Create anonymous user
method: get  
path: /api/users/anonymous  

### Sign in user
method: get   
path: /api/users/sign_in  

### Get recommended keywords, colors and 2 results from history for user with :id
method: get  
path: /api/users/:id/recomendations  
params:
  - page - number of page. Used for results pagination. Not required

### Get recent products from history of user with :id
method: get  
path: /api/users/:id/products/recent  
params:
  - page - number of page. Used for results pagination. Not required

### Search products in history of user with :id
method: get  
path: /api/users/:id/products/search  
params:
  - page - number of page. Used for results pagination. Not required

### Add product to history of user with :id
method: post  
path: /api/users/:id/products  

### Delete product from history of user with :id
method: delete  
path: /api/users/:id/products  

### Search products among all
method: get  
path: /api/products/search  
params:
  - page - number of page. Used for results pagination. Not required

Specfiying responses
-------------------

Every API endpoint except delete and add product will return response in JSON format.
Those responses are specified in YAML files in Fixtures directory. Fixture files are named according to thier API endpoints names. For example `/api/users/:id/recommendations` will get data from `Fixtures/users_recommendations.yml`
