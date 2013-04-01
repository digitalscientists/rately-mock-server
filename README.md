Set Up
======

After cloning enter project directory and execute command: `bundle install`.

To start server use command: `bundle exec ruby server.rb`.

Usage
=====

Header of each request should contain `rately_token`, by this token user of application will be identified.
If request does not include `rately_token`, then anonymous user will be created and his `rately_token` will be returned in response header.

API
---
### Sign in user
method: post   
path: /api/users/authorize  

### Get recommended keywords, colors and 2 results from history for user with :id
method: get  
path: /api/users/:id/recommendations  
params:
  - page - number of page. Used for results pagination. Not required

### Get recent products from history of user with :id
method: get  
path: /api/users/:id/products/recent  
params:
  - page - number of page. Used for results pagination. Not required

### Search products in history of user with :id
method: post  
path: /api/users/:id/products/search  
params:
  - payload JSON-formated query where key is name of field to search by and value is term that field should match
  - page - number of page. Used for results pagination. Not required

### Add product to history of user with :id
method: post  
path: /api/users/:id/products  

### Delete product from history of user with :id
method: delete  
path: /api/users/:id/products  

### Search products among all
method: post  
path: /api/products/search  
params:
  - payload JSON-formated query where key is name of field to search by and value is term that field should match
  - page - number of page. Used for results pagination. Not required

Specfiying responses
-------------------

Every API endpoint except delete and add product will return response in JSON format.
Those responses are specified in YAML files in Fixtures directory. Fixture files are named according to thier API endpoints names. For example `/api/users/:id/recommendations` will get data from `Fixtures/users_recommendations.yml`
