# id,invoice_id,credit_card_number,credit_card_expiration_date,result,created_at,updated_at
require 'rails_helper'

RSpec.describe "GET /api/v1/transactions" do
  def parsed_response
    JSON.parse(response.body)
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
  end

  it "returns a list of all transactions" do
    merchant1 = create(:merchant, name: "Brennan")
    merchant2 = create(:merchant, name: "John")
    customer1 = create(:customer, first_name: "Brennan", last_name: "Doe")
    customer2 = create(:customer, first_name: "John", last_name: "Doe")
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant2.id)
    item3 = create(:item, merchant_id: merchant1.id)
    invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id)
    invoice2 = create(:invoice, customer_id: customer2.id, merchant_id: merchant1.id)
    invoice3 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id, status: "Paid")
    invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)
    invoice_item3 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
    transaction1 = create(:transaction, item_id: item1.id, invoice_id: invoice1.id)
    transaction2 = create(:transaction, item_id: item2.id, invoice_id: invoice2.id)
    transaction3 = create(:transaction, item_id: item1.id, invoice_id: invoice1.id)

    get "/api/v1/transactions"

    expect(parsed_response.count).to eq(3)

    expect(parsed_response[0]).to eq({
      "id"         => transaction1.id,
      "item_id" => transaction1.item_id,
      "invoice_id" => transaction1.invoice_id,
      "quantity" => transaction1.quantity,
      "unit_price" => transaction1.unit_price,
      "created_at" => format_date(transaction1.created_at),
      "updated_at" => format_date(transaction1.updated_at)
    })

    expect(parsed_response[1]["id"]).to eq(transaction2.id)
    expect(parsed_response[2]["id"]).to eq(transaction3.id)
  end
#
#   it "returns just one transaction by id" do
#     merchant1 = create(:merchant, name: "Brennan")
#     merchant2 = create(:merchant, name: "John")
#     customer1 = create(:customer, first_name: "Brennan", last_name: "Doe")
#     customer2 = create(:customer, first_name: "John", last_name: "Doe")
#     item1 = create(:item, merchant_id: merchant1.id)
#     item2 = create(:item, merchant_id: merchant2.id)
#     item3 = create(:item, merchant_id: merchant1.id)
#     invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id)
#     invoice2 = create(:invoice, customer_id: customer2.id, merchant_id: merchant1.id)
#     invoice3 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id, status: "Paid")
#     transaction1 = create(:transaction, item_id: item1.id, invoice_id: invoice1.id)
#     transaction2 = create(:transaction, item_id: item2.id, invoice_id: invoice2.id)
#     transaction3 = create(:transaction, item_id: item1.id, invoice_id: invoice1.id)
#
#     get "/api/v1/transactions/#{transaction1.id}"
#
#     expect(parsed_response).to eq({
#       "id"         => transaction1.id,
#       "item_id"    => transaction1.item_id,
#       "invoice_id" => transaction1.invoice_id,
#       "quantity"   => transaction1.quantity,
#       "unit_price" => transaction1.unit_price,
#       "created_at" => format_date(transaction1.created_at),
#       "updated_at" => format_date(transaction1.updated_at)
#     })
#
#     expect(parsed_response).to_not include(transaction2.id)
#   end
#
#   it "returns just one transaction by any criteria" do
#     merchant1 = create(:merchant, name: "Brennan")
#     merchant2 = create(:merchant, name: "John")
#     customer1 = create(:customer, first_name: "Brennan", last_name: "Doe")
#     customer2 = create(:customer, first_name: "John", last_name: "Doe")
#     item1 = create(:item, merchant_id: merchant1.id)
#     item2 = create(:item, merchant_id: merchant2.id)
#     item3 = create(:item, merchant_id: merchant1.id)
#     invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id)
#     invoice2 = create(:invoice, customer_id: customer2.id, merchant_id: merchant1.id)
#     invoice3 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id, status: "Paid")
#     transaction1 = create(:transaction, item_id: item1.id, invoice_id: invoice1.id)
#     transaction2 = create(:transaction, item_id: item2.id, invoice_id: invoice2.id, unit_price: 999)
#     transaction3 = create(:transaction, item_id: item1.id, invoice_id: invoice1.id, quantity: 888)
#
#     get "/api/v1/transactions/find?id=#{transaction1.id}"
#
#     expect(parsed_response).to eq({
#       "id"         => transaction1.id,
#       "item_id"    => transaction1.item_id,
#       "invoice_id" => transaction1.invoice_id,
#       "quantity"   => transaction1.quantity,
#       "unit_price" => transaction1.unit_price,
#       "created_at" => format_date(transaction1.created_at),
#       "updated_at" => format_date(transaction1.updated_at)
#     })
#
#     get "/api/v1/transactions/find?unit_price=#{transaction2.unit_price}"
#
#     expect(parsed_response).to eq({
#       "id"         => transaction2.id,
#       "item_id"    => transaction2.item_id,
#       "invoice_id" => transaction2.invoice_id,
#       "quantity"   => transaction2.quantity,
#       "unit_price" => transaction2.unit_price,
#       "created_at" => format_date(transaction2.created_at),
#       "updated_at" => format_date(transaction2.updated_at)
#     })
#
#     get "/api/v1/transactions/find?quantity=#{transaction3.quantity}"
#
#     expect(parsed_response).to eq({
#       "id"         => transaction3.id,
#       "item_id"    => transaction3.item_id,
#       "invoice_id" => transaction3.invoice_id,
#       "quantity"   => transaction3.quantity,
#       "unit_price" => transaction3.unit_price,
#       "created_at" => format_date(transaction3.created_at),
#       "updated_at" => format_date(transaction3.updated_at)
#     })
#   end
#
#   it "returns all transactions by any criteria" do
#     merchant1 = create(:merchant, name: "Brennan")
#     merchant2 = create(:merchant, name: "John")
#     customer1 = create(:customer, first_name: "Brennan", last_name: "Doe")
#     customer2 = create(:customer, first_name: "John", last_name: "Doe")
#     item1 = create(:item, merchant_id: merchant1.id)
#     item2 = create(:item, merchant_id: merchant2.id)
#     item3 = create(:item, merchant_id: merchant1.id)
#     invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id)
#     invoice2 = create(:invoice, customer_id: customer2.id, merchant_id: merchant1.id)
#     invoice3 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id, status: "Paid")
#     transaction1 = create(:transaction, item_id: item1.id, invoice_id: invoice1.id)
#     transaction2 = create(:transaction, item_id: item2.id, invoice_id: invoice2.id, quantity: 45)
#     transaction3 = create(:transaction, item_id: item1.id, invoice_id: invoice1.id, quantity: 45)
#
#     get "/api/v1/transactions/find_all?id=#{transaction1.id}"
#
#     expect(parsed_response[0]).to eq({
#       "id"         => transaction1.id,
#       "item_id"    => transaction1.item_id,
#       "invoice_id" => transaction1.invoice_id,
#       "quantity"   => transaction1.quantity,
#       "unit_price" => transaction1.unit_price,
#       "created_at" => format_date(transaction1.created_at),
#       "updated_at" => format_date(transaction1.updated_at)
#     })
#
#     get "/api/v1/transactions/find_all?item_id=#{transaction1.item_id}"
#
#     expect(parsed_response.count).to eq(2)
#
#     expect(parsed_response.first["invoice_id"]).to eq(transaction1.invoice_id)
#     expect(parsed_response.first["quantity"]).to eq(transaction1.quantity)
#     expect(parsed_response.last["invoice_id"]).to eq(transaction3.invoice_id)
#     expect(parsed_response.last["quantity"]).to eq(transaction3.quantity)
#     expect(parsed_response).to_not include(JSON.parse(transaction2.to_json))
#
#     get "/api/v1/transactions/find_all?quantity=#{transaction2.quantity}"
#
#     expect(parsed_response.count).to eq(2)
#
#     expect(parsed_response.first["invoice_id"]).to eq(transaction2.invoice_id)
#     expect(parsed_response.first["quantity"]).to eq(transaction2.quantity)
#     expect(parsed_response.last["invoice_id"]).to eq(transaction3.invoice_id)
#     expect(parsed_response.last["quantity"]).to eq(transaction3.quantity)
#     expect(parsed_response).to_not include(JSON.parse(transaction1.to_json))
#   end
# end
