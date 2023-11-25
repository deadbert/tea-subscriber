# README

Practice API application that imagines handling tea subscriptions for a front facing web app. Database is postgresql, and holds data on specific teas, customers and subscriptions. Customer passwords are salted and hashed uzing bcrypt for authentication in this Back End app. 

## How to run the app localy for testing
- Fork and clone a copy of the repo down to your local machine
- run `bundle install` in terminal to install all gem dependencies
- run `rails db:create`
- run `rails db:migrate` to run all built migrations
- run `rails s` to spin up  the server on localhost:3000 port
- server will be running and can be tested using a FE app or accessed with a program like Postman

## Endpoints

### POST Endpoints
#### "/api/v1/subscriptions"
- required params: {tile, price, status, frequency customer_id, tea_id}
- params must be passed in the body of the request, not query parameters
- this endpoint takes the given parameters and creates a new Subscription on the backend DB for the given customer_id

#### "/api/v1/customers
- required params: {first_name, last_name, email, address, password}
- submit params in the body of the request, password should be the raw user password, salting and hashing occours on the Back End to create a password_digest
- this endpoint creates a new customer in the DB using the given parameters

#### "/api/v1/teas"
- required params: {title, description, temperature, brew_time}
- submit params in the body of the request
- this endpoint creates a new tea entry in the DB using the given params

### GET Endpoints
#### "/api/v1/subscriptions"
- required params: {customer_id}
- param can be passed as a query parameter
- endpoint returns all subscriptions, active or cancelled associated with the given customer_id

#### "/api/v1/customers"
- no required params
- this endpoint will return a list of all current customers in the back end DB, not including any password information

#### "/api/v1/teas"
- no required params
- this endpoint will return a list of all current tea entries in the DB

### PATCH Endpoints
#### "/api/v1/subscriptions/{subscription_id}"
- required params: {status}
- param can be passed as a query parameter subscription_id should be passed as part of the url
- example: "/api/v2/subscriptions/1?status=cancelled"
- endpoint is used for cancelling or re-activating a subscription for a customer
