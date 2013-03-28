Set Up
======

After cloning enter project directory and execute command: `bundle install`.

To start server use command: `bundle exec ruby server.rb`.

Usage
=====

API
---
### creates anonymous user
method: get  
path: /api/users/anonymous  

### sign in user
method: get 
path: /api/users/sign_in

### recommended keywords, colors and 2 results from history for user with :id
method: get 
path: /api/users/:id/recomendations
params:
  - page - used for results pagination; not required

### recent products from history of user with :id
method: get 
path: /api/users/:id/products/recent
params:
  - page - used for results pagination; not required

### search products in history of user with :id
method: get 
path: /api/users/:id/products/search
params:
  - page - used for results pagination; not required

### add product to history of user with :id
method: post 
path: /api/users/:id/products

### delete product from history of user with :id
method: delete 
path: /api/users/:id/products

### search products among all
method: get 
path: /api/products/search
params:
  - page - used for results pagination; not required

Specfiying responses
-------------------

Every API endpoint except delete and add product will return response in JSON format.
Those responses are specified in YAML files in Fixtures directory. Fixture files are named according to thier API endpoints names. For example `/api/users/:id/recommendations` will get data from `Fixtures/users_recommendations.yml`
