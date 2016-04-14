require 'rails_helper'

RSpec.describe "GET /api/v1/invoices" do
  def parsed_response
    JSON.parse(response.body)
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
  end

  it "returns a list of all invoices" do
    merchant1 = create(:merchant, name: "Brennan")
    merchant2 = create(:merchant, name: "John")
    customer1 = create(:customer, first_name: "Brennan", last_name: "Doe")
    customer2 = create(:customer, first_name: "John", last_name: "Doe")
    invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id)
    invoice2 = create(:invoice, customer_id: customer2.id, merchant_id: merchant1.id)
    invoice3 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id, status: "Paid")

    get "/api/v1/invoices"

    expect(parsed_response.count).to eq(3)

    expect(parsed_response[0]).to eq({
      "id"         => invoice1.id,
      "customer_id" => invoice1.customer_id,
      "merchant_id" => invoice1.merchant_id,
      "status" => invoice1.status,
      "created_at" => format_date(invoice1.created_at),
      "updated_at" => format_date(invoice1.updated_at)
    })

    expect(parsed_response[1]["status"]).to eq(invoice2.status)
    expect(parsed_response[2]["status"]).to eq(invoice3.status)
  end

  it "returns just one invoice by id" do
    merchant1 = create(:merchant, name: "Brennan")
    merchant2 = create(:merchant, name: "John")
    customer1 = create(:customer, first_name: "Brennan", last_name: "Doe")
    customer2 = create(:customer, first_name: "John", last_name: "Doe")
    invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id)
    invoice2 = create(:invoice, customer_id: customer2.id, merchant_id: merchant1.id)
    invoice3 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id, status: "Paid")

    get "/api/v1/invoices/#{invoice1.id}"

    expect(parsed_response).to eq({
      "id"         => invoice1.id,
      "customer_id" => invoice1.customer_id,
      "merchant_id" => invoice1.merchant_id,
      "status" => invoice1.status,
      "created_at" => format_date(invoice1.created_at),
      "updated_at" => format_date(invoice1.updated_at)
    })

    expect(parsed_response).to_not include(invoice2.id)
  end

  it "returns just one invoice by any criteria" do
    merchant1 = create(:merchant, name: "Brennan")
    merchant2 = create(:merchant, name: "John")
    customer1 = create(:customer, first_name: "Brennan", last_name: "Doe")
    customer2 = create(:customer, first_name: "John", last_name: "Doe")
    invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id)
    invoice2 = create(:invoice, customer_id: customer2.id, merchant_id: merchant1.id)
    invoice3 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id, status: "Paid")


    get "/api/v1/invoices/find?id=#{invoice1.id}"

    expect(parsed_response).to eq({
      "id"         => invoice1.id,
      "customer_id" => invoice1.customer_id,
      "merchant_id" => invoice1.merchant_id,
      "status" => invoice1.status,
      "created_at" => format_date(invoice1.created_at),
      "updated_at" => format_date(invoice1.updated_at)
    })

    get "/api/v1/invoices/find?status=#{invoice3.status}"

    expect(parsed_response).to eq({
      "id"         => invoice3.id,
      "customer_id" => invoice3.customer_id,
      "merchant_id" => invoice3.merchant_id,
      "status" => invoice3.status,
      "created_at" => format_date(invoice3.created_at),
      "updated_at" => format_date(invoice3.updated_at)
    })
  end

  it "returns all invoices by any criteria" do
    merchant1 = create(:merchant, name: "Brennan")
    merchant2 = create(:merchant, name: "John")
    customer1 = create(:customer, first_name: "Brennan", last_name: "Doe")
    customer2 = create(:customer, first_name: "John", last_name: "Doe")
    invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id)
    invoice2 = create(:invoice, customer_id: customer2.id, merchant_id: merchant1.id)
    invoice3 = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id, status: "Paid")

    get "/api/v1/invoices/find_all?id=#{invoice1.id}"

    expect(parsed_response[0]).to eq({
      "id"         => invoice1.id,
      "customer_id" => invoice1.customer_id,
      "merchant_id" => invoice1.merchant_id,
      "status" => invoice1.status,
      "created_at" => format_date(invoice1.created_at),
      "updated_at" => format_date(invoice1.updated_at)
    })

    get "/api/v1/invoices/find_all?customer_id=#{invoice1.customer_id}"

    expect(parsed_response.count).to eq(2)

    expect(parsed_response.first["customer_id"]).to eq(invoice1.customer_id)
    expect(parsed_response.first["status"]).to eq(invoice1.status)
    expect(parsed_response.last["customer_id"]).to eq(invoice3.customer_id)
    expect(parsed_response.last["status"]).to eq(invoice3.status)
    expect(parsed_response).to_not include(JSON.parse(invoice2.to_json))
  end
end
