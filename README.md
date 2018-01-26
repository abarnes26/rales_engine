Rales Engine
Project Description
In this project, you will use Rails and ActiveRecord to build a JSON API which exposes the SalesEngine data schema.

The project requirements are listed below:

Learning Goals
Technical Expectations
Check-ins
Evaluation
Learning Goals
Learn how to to build Single-Responsibility controllers to provide a well-designed and versioned API.
Learn how to use controller tests to drive your design.
Use Ruby and ActiveRecord to perform more complicated business intelligence.
Dividing the Work
You should create stories divided the following way to make sure both team members get exposure to all major components of the project and are able to hit the learning goals above.

Record Endpoints

Person A
Merchants
Transactions
Customers
Person B
Invoices
Items
Invoice Items
Relationship Endpoints

Person A
Invoices
Items
Invoice Items
Person B
Merchants
Transactions
Customers
Business Intelligence Endpoints

(This portion should be a good starting point for balancing the work. If this seems uneven let the staff know so they can make adjustments.)

Person A
GET /api/v1/merchants/:id/revenue
GET /api/v1/merchants/:id/revenue?date=x
GET /api/v1/merchants/most_items?quantity=x
GET /api/v1/customers/:id/favorite_merchant
GET /api/v1/items/:id/best_day
GET /api/v1/items/most_items?quantity=x
Person B
GET /api/v1/merchants/:id/customers_with_pending_invoices
GET /api/v1/merchants/:id/favorite_customer
GET /api/v1/items/most_revenue?quantity=x
GET /api/v1/merchants/revenue?date=x
GET /api/v1/merchants/most_revenue?quantity=x
Technical Expectations
All endpoints will expect to return JSON data
All endpoints should be exposed under an api and version (v1) namespace (e.g. /api/v1/merchants.json)
JSON responses should include ids only for associated records unless otherwise indicated (that is, don’t embed the whole associated record, just the id)
Prices are in cents, therefore you will need to transform them in dollars. (12345 becomes 123.45)
Remember that for a JSON string to be valid, it needs to contain a key and a value.
Data Importing
You will create an ActiveRecord model for each entity included in the sales engine data.
Your application should include a rake task which imports all of the CSV’s and creates the corresponding records.
Record Endpoints
Index of Record
Each data category should include an index action which renders a JSON representation of all the appropriate records:

Request URL
GET /api/v1/merchants.json

JSON Output
(The following is an example of a response if only three records were saved in the database)

[
  {
    "id":1,
    "name":"Schroeder-Jerde"
  },
  {
    "id":2,
    "name":"Klein, Rempel and Jones"
  },
  {
    "id":3,
    "name":"Willms and Sons"
  }
]
Show Record
Each data category should include a show action which renders a JSON representation of the appropriate record:

Request URL
GET /api/v1/merchants/1.json

JSON Output
{
  "id":1,
  "name":"Schroeder-Jerde"
}
Single Finders
Each data category should offer find finders to return a single object representation. The finder should work with any of the attributes defined on the data type and always be case insensitive.

Request URL
GET /api/v1/merchants/find?parameters
Request Parameters
parameter	description
id	search based on the primary key
name	search based on the name attribute
created_at	search based on created_at timestamp
updated_at	search based on updated_at timestamp
JSON Output
GET /api/v1/merchants/find?name=Schroeder-Jerde

{  
   "id":1,
   "name":"Schroeder-Jerde"
}
Multi-Finders
Each category should offer find_all finders which should return all matches for the given query. It should work with any of the attributes defined on the data type and always be case insensitive.

Request URL
GET /api/v1/merchants/find_all?parameters

Request Parameters
parameter	description
id	search based on the primary key
name	search based on the name attribute
created_at	search based on created_at timestamp
updated_at	search based on updated_at timestamp
JSON Output
GET /api/v1/merchants/find_all?name=Cummings-Thiel

[  
   {  
      "id":4,
      "name":"Cummings-Thiel"
   }
]
Note: Although this search returns one record, it comes back in an array.

Random
Request URL
Returns a random resource.

api/v1/merchants/random.json

{
  "id": 50,
  "name": "Nader-Hyatt"
}
Relationship Endpoints
In addition to the direct queries against single resources, we would like to also be able to pull relationship data from the API.

We’ll expose these relationships using nested URLs, as outlined in the sections below.

Merchants
GET /api/v1/merchants/:id/items returns a collection of items associated with that merchant
GET /api/v1/merchants/:id/invoices returns a collection of invoices associated with that merchant from their known orders
Invoices
GET /api/v1/invoices/:id/transactions returns a collection of associated transactions
GET /api/v1/invoices/:id/invoice_items returns a collection of associated invoice items
GET /api/v1/invoices/:id/items returns a collection of associated items
GET /api/v1/invoices/:id/customer returns the associated customer
GET /api/v1/invoices/:id/merchant returns the associated merchant
Invoice Items
GET /api/v1/invoice_items/:id/invoice returns the associated invoice
GET /api/v1/invoice_items/:id/item returns the associated item
Items
GET /api/v1/items/:id/invoice_items returns a collection of associated invoice items
GET /api/v1/items/:id/merchant returns the associated merchant
Transactions
GET /api/v1/transactions/:id/invoice returns the associated invoice
Customers
GET /api/v1/customers/:id/invoices returns a collection of associated invoices
GET /api/v1/customers/:id/transactions returns a collection of associated transactions
Business Intelligence Endpoints
We want to maintain the original Business Intelligence functionality of SalesEngine, but this time expose the data through our API.

Remember that ActiveRecord is your friend. Much of the complicated logic from your original SalesEngine can be expressed quite succinctly using ActiveRecord queries.

All Merchants
GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue
GET /api/v1/merchants/most_items?quantity=x returns the top x merchants ranked by total number of items sold
GET /api/v1/merchants/revenue?date=x returns the total revenue for date x across all merchants
Assume the dates provided match the format of a standard ActiveRecord timestamp.

Single Merchant
GET /api/v1/merchants/:id/revenue returns the total revenue for that merchant across successful transactions
GET /api/v1/merchants/:id/revenue?date=x returns the total revenue for that merchant for a specific invoice date x
GET /api/v1/merchants/:id/favorite_customer returns the customer who has conducted the most total number of successful transactions.
BOSS MODE: GET /api/v1/merchants/:id/customers_with_pending_invoices returns a collection of customers which have pending (unpaid) invoices. A pending invoice has no transactions with a result of success. This means all transactions are failed. Postgres has an EXCEPT operator that might be useful. ActiveRecord also has a find_by_sql that might help.
NOTE: Failed charges should never be counted in revenue totals or statistics.

NOTE: All revenues should be reported as a float with two decimal places.

Items
GET /api/v1/items/most_revenue?quantity=x returns the top x items ranked by total revenue generated
GET /api/v1/items/most_items?quantity=x returns the top x item instances ranked by total number sold
GET /api/v1/items/:id/best_day returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.
Customers
GET /api/v1/customers/:id/favorite_merchant returns a merchant where the customer has conducted the most successful transactions
