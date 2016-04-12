require 'rails_helper'

RSpec.describe "GET /api/v1/invoice_items" do
  def parsed_response
    JSON.parse(response.body)
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
  end

  it "returns a list of all invoice_items" do
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

    get "/api/v1/invoice_items"

    expect(parsed_response.count).to eq(3)

    expect(parsed_response[0]).to eq({
      "id"         => invoice_item1.id,
      "item_id" => invoice_item1.item_id,
      "invoice_id" => invoice_item1.invoice_id,
      "quantity" => invoice_item1.quantity,
      "unit_price" => invoice_item1.unit_price.to_s,
      "created_at" => format_date(invoice_item1.created_at),
      "updated_at" => format_date(invoice_item1.updated_at)
    })

    expect(parsed_response[1]["id"]).to eq(invoice_item2.id)
    expect(parsed_response[2]["id"]).to eq(invoice_item3.id)
  end

  it "returns just one invoice_item by id" do
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

    get "/api/v1/invoice_items/#{invoice_item1.id}"

    expect(parsed_response).to eq({
      "id"         => invoice_item1.id,
      "item_id"    => invoice_item1.item_id,
      "invoice_id" => invoice_item1.invoice_id,
      "quantity"   => invoice_item1.quantity,
      "unit_price" => invoice_item1.unit_price.to_s,
      "created_at" => format_date(invoice_item1.created_at),
      "updated_at" => format_date(invoice_item1.updated_at)
    })

    expect(parsed_response).to_not include(invoice_item2.id)
  end

  it "returns just one invoice_item by any criteria" do
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
    invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id, unit_price: 999)
    invoice_item3 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, quantity: 888)

    get "/api/v1/invoice_items/find?id=#{invoice_item1.id}"

    expect(parsed_response).to eq({
      "id"         => invoice_item1.id,
      "item_id"    => invoice_item1.item_id,
      "invoice_id" => invoice_item1.invoice_id,
      "quantity"   => invoice_item1.quantity,
      "unit_price" => invoice_item1.unit_price.to_s,
      "created_at" => format_date(invoice_item1.created_at),
      "updated_at" => format_date(invoice_item1.updated_at)
    })

    get "/api/v1/invoice_items/find?unit_price=#{invoice_item2.unit_price}"

    expect(parsed_response).to eq({
      "id"         => invoice_item2.id,
      "item_id"    => invoice_item2.item_id,
      "invoice_id" => invoice_item2.invoice_id,
      "quantity"   => invoice_item2.quantity,
      "unit_price" => invoice_item2.unit_price.to_s,
      "created_at" => format_date(invoice_item2.created_at),
      "updated_at" => format_date(invoice_item2.updated_at)
    })

    get "/api/v1/invoice_items/find?quantity=#{invoice_item3.quantity}"

    expect(parsed_response).to eq({
      "id"         => invoice_item3.id,
      "item_id"    => invoice_item3.item_id,
      "invoice_id" => invoice_item3.invoice_id,
      "quantity"   => invoice_item3.quantity,
      "unit_price" => invoice_item3.unit_price.to_s,
      "created_at" => format_date(invoice_item3.created_at),
      "updated_at" => format_date(invoice_item3.updated_at)
    })
  end

  it "returns all invoice_items by any criteria" do
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
    invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id, quantity: 45)
    invoice_item3 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, quantity: 45)

    get "/api/v1/invoice_items/find_all?id=#{invoice_item1.id}"

    expect(parsed_response[0]).to eq({
      "id"         => invoice_item1.id,
      "item_id"    => invoice_item1.item_id,
      "invoice_id" => invoice_item1.invoice_id,
      "quantity"   => invoice_item1.quantity,
      "unit_price" => invoice_item1.unit_price.to_s,
      "created_at" => format_date(invoice_item1.created_at),
      "updated_at" => format_date(invoice_item1.updated_at)
    })

    get "/api/v1/invoice_items/find_all?item_id=#{invoice_item1.item_id}"

    expect(parsed_response.count).to eq(2)

    expect(parsed_response.first["invoice_id"]).to eq(invoice_item1.invoice_id)
    expect(parsed_response.first["quantity"]).to eq(invoice_item1.quantity)
    expect(parsed_response.last["invoice_id"]).to eq(invoice_item3.invoice_id)
    expect(parsed_response.last["quantity"]).to eq(invoice_item3.quantity)
    expect(parsed_response).to_not include(JSON.parse(invoice_item2.to_json))

    get "/api/v1/invoice_items/find_all?quantity=#{invoice_item2.quantity}"

    expect(parsed_response.count).to eq(2)

    expect(parsed_response.first["invoice_id"]).to eq(invoice_item2.invoice_id)
    expect(parsed_response.first["quantity"]).to eq(invoice_item2.quantity)
    expect(parsed_response.last["invoice_id"]).to eq(invoice_item3.invoice_id)
    expect(parsed_response.last["quantity"]).to eq(invoice_item3.quantity)
    expect(parsed_response).to_not include(JSON.parse(invoice_item1.to_json))
  end
end
