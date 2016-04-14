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
    transaction1 = create(:transaction, invoice_id: invoice1.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id)
    transaction3 = create(:transaction, invoice_id: invoice1.id)

    get "/api/v1/transactions"

    expect(parsed_response.count).to eq(3)

    expect(parsed_response[0]).to eq({
      "id"         => transaction1.id,
      "invoice_id" => transaction1.invoice_id,
      "credit_card_number" => transaction1.credit_card_number,
      "result" => transaction1.result,
      "created_at" => format_date(transaction1.created_at),
      "updated_at" => format_date(transaction1.updated_at)
    })

    expect(parsed_response[1]["id"]).to eq(transaction2.id)
    expect(parsed_response[2]["id"]).to eq(transaction3.id)
  end

  it "returns just one transaction by id" do
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
    transaction1 = create(:transaction, invoice_id: invoice1.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id)
    transaction3 = create(:transaction, invoice_id: invoice1.id)

    get "/api/v1/transactions/#{transaction1.id}"

    expect(parsed_response).to eq({
      "id"         => transaction1.id,
      "invoice_id" => transaction1.invoice_id,
      "credit_card_number" => transaction1.credit_card_number,
      "result" => transaction1.result,
      "created_at" => format_date(transaction1.created_at),
      "updated_at" => format_date(transaction1.updated_at)
    })

    expect(parsed_response).to_not include(transaction2.id)
  end

  it "returns just one transaction by any criteria" do
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
    transaction1 = create(:transaction, invoice_id: invoice1.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id, result: "rejected")
    transaction3 = create(:transaction, invoice_id: invoice1.id)

    get "/api/v1/transactions/find?id=#{transaction1.id}"

    expect(parsed_response).to eq({
      "id"         => transaction1.id,
      "invoice_id" => transaction1.invoice_id,
      "credit_card_number" => transaction1.credit_card_number,
      "result" => transaction1.result,
      "created_at" => format_date(transaction1.created_at),
      "updated_at" => format_date(transaction1.updated_at)
    })

    get "/api/v1/transactions/find?result=#{transaction2.result}"

    expect(parsed_response).to eq({
      "id"         => transaction2.id,
      "invoice_id" => transaction2.invoice_id,
      "credit_card_number" => transaction2.credit_card_number,
      "result" => transaction2.result,
      "created_at" => format_date(transaction2.created_at),
      "updated_at" => format_date(transaction2.updated_at)
    })
  end

  it "returns all transactions by any criteria" do
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
    transaction1 = create(:transaction, invoice_id: invoice1.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id, result: "rejected")
    transaction3 = create(:transaction, invoice_id: invoice1.id, result: "chopped up")

    get "/api/v1/transactions/find_all?id=#{transaction1.id}"

    expect(parsed_response[0]).to eq({
      "id"         => transaction1.id,
      "invoice_id" => transaction1.invoice_id,
      "credit_card_number" => transaction1.credit_card_number,
      "result" => transaction1.result,
      "created_at" => format_date(transaction1.created_at),
      "updated_at" => format_date(transaction1.updated_at)
    })

    get "/api/v1/transactions/find_all?invoice_id=#{transaction1.invoice_id}"

    expect(parsed_response.count).to eq(2)

    expect(parsed_response.first["invoice_id"]).to eq(transaction1.invoice_id)
    expect(parsed_response.first["result"]).to eq(transaction1.result)
    expect(parsed_response.last["invoice_id"]).to eq(transaction3.invoice_id)
    expect(parsed_response.last["result"]).to eq(transaction3.result)
    expect(parsed_response).to_not include(JSON.parse(transaction2.to_json))
  end
end
