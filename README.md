# README

Practice API application that imagines handling tea subscriptions for a front facing web app. Database is postgresql, and hold data on specific teas, customers and subscriptions. Authentication is currently assumed to be handled on front end application, but could easily be handled in this application with current set up. Simply enable bcrypt from Gemfile and add a password_digest column to User model, as well as create a User creation endpoint.

## Endpoints

### POST Endpoints
#### "/api/v1/subscriptions"
- required params: {tile, price, status, frequency customer_id, tea_id}
- params must be passed in the body of the request, not query parameters
- this endpoint takes the given parameters and creates a new Subscription on the backend DB for the given customer_id

### GET Endpoints
#### "/api/v1/subscriptions"
- required params: {customer_id}
- param can be passed as a query parameter
- endpoint returns all subscriptions, active or cancelled associated with the given customer_id

### PATCH Endpoints
#### "/api/v1/subscriptions/{subscription_id}"
- required params: {status}
- param can be passed as a query parameter subscription_id should be passed as part of the url
- example: "/api/v2/subscriptions/1?status=cancelled"
- endpoint is used for cancelling or re-activating a subscription for a customer
