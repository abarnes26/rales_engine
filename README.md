# Rales Engine

## Goal of this Project
- Build Single-Responsibility Controllers that provide an API that's (a) well-designed and (b) versioned
- Use controller tests to drive design.
- Use Ruby and ActiveRecord to perform complicated business intelligence.
- Users can access data relating to business intelligence and basic model relationships.

## Getting Started
To get started, clone down this reposotory and run the following command - 
```
bundle
```
from the command line.  Once the folder is bundled run the following command - 
```
rails db:setup
```
to create your databases and load all necessary data from the local csv files into your database.

### Testing

This project has it's own internal set of tests to maintain structure and functionality. Once you have set up your databases and loaded all necessary data, these tests can be accessed by running the following command -

```
rspec
```

### Additional Testing

Furthermore this application can be run against a more comprehensive set of feature tests which use your local server to test functions.  These additional specifications can be found [here](https://github.com/turingschool-examples/sales_engine/tree/master/data).  Simply clone this folder into the same parent directory as where you cloned the Rales engine application and run ``` bundle ``` to get set up.   

From inside the Rales Engine directory, run the command ``` rails s ``` to start your local server.  Then from inside the folder containing the additional specifications, run any of the following - 
```
rake
```
```rake test```
``` bundle exec rake test ``` (much more readable output)

## An Overview of the data relationships

The data in this project is a mock setup of an e-commerce store involving relationships between Customers, Merchants, Items and Sales (broken up into Invoices, Invoice_Items, and Transactions).  The schema illustrating these relationships can be found below -

![alt text](https://lh3.googleusercontent.com/npVkpXwAyJVUrUkd_PotEaVuue_qCmA9TYhiRg4nWUblNmeEeQxJeIlPfQOtdRwnL6ufKUL3A30AWc1gc0AbJpnkuq6GUt-XXHTWGyDXugck4lT3C2xBZkHQRR_7kCR5-YW1T3RKAKTojaktyDLy0DkivSUV1vDefhWGDzUm-1x0vP80AHxSNXE2juedqDag9oMyX0Mq59LN6JFH72V9-UF1sFMB99zTwiSbNknjF0Te-PLvitxd4dzYQh4gu2s3KiosC9n1Ns5H9_2_-iWSyTXpuHUuur-7Ht5TZfQ4TEok6dEMYwyvVAUorqG_yC86DTnh8PLpZJQzLOYpCqUh0mdumozSfQdNHWMV3Lpy8QbyQzJIVQSNFQ-FbudIMPdHfByEmSuBijdg8dTgsa2NJWDA75qtCw_BTPDKg8Tan-A_dtqrxN31c3lDvuIxNLMGnC8Eryv77klBVglAbQ02C0jIyyTdyzpoSVYBtKJQjx2e86ZNUwnSDIFg1nJ1fmgzBAe97FRapPqiX-PQTS1VeOCnUOeNJWGz6vlKIKzqoH9cszLfxt93PZz7MXPFP4VC=w2560-h1216.png)




