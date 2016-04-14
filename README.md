# Rails Engine

If you google ```rails engine``` you'll find some nifty information on how to generate a Plugin in Rails.

This is not that kind of a Rails Engine.


Instead, what I've done is taken the bones of an old project, and given it my own engine to turn the whole thing into an API.

To get started follow the instructions below:

```
git clone git@github.com:brennanholtzclaw/rails_engine.git mirror_rails_engine

bundle

rake db:{drop,create,migrate}

rake import:{customers,merchants,items,invoices,invoice_items,transactions}

```
You can probably refill your coffee here

Then, to double check that all went well, run ``` rspec ``` and see the test suit pass.


### What's Happening?

Sales Engine was a project designed to help you understand how relationships work on the back end. Rails Engine on the other hand is designed to help you understand how an API can be delivered to a wider audience. This database represents what you might see on the backend of an e-commerce site. By hitting various endpoints you can query the database to learn what's going on with the store.

With a server running through ``` rails s ``` you can test out some routes for yourself.

For instance, if you wanted to know all of the merchants associated with the multi-tenant platform you could hit ``` /api/v1/merchants ``` .
If you were curious about information on a random customer you would hit the ``` /api/v1/customers/random ``` endpoint.

There are 6 main hubs for endpoints corresponding to tables in the database:
```
customers
merchants
items
invoices
invoice_items (which are like line-items on an invoice)
transactions
```

All of those hubs have five shared endpoints: ``` show, index, find, find_all, random ```

In addition, there are a few relationships you can query. For instance, hitting ``` /api/v1/items/most_items ``` will give you all items sorted by whichever item has sold the most units. Add a param like ``` ?quantity=10 ``` to limit the return to 10 results.
Be careful here, nothing is paginated yet, so this could be quite the return.
