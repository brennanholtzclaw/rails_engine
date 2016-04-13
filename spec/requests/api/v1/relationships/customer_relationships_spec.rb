require "rails_helper"


RSpec.describe "GET /api/v1/customers/ relationships" do
  def parsed_response
    JSON.parse(response.body)
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
  end

  it "returns a list of all customer invoices" do
    # GET /api/v1/customers/:id/invoices returns a collection of associated invoices
    customer = create(:customer)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice3 = create(:invoice)
    customer.invoices << invoice1
    customer.invoices << invoice2

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(parsed_response.count).to eq(2)
    expect(parsed_response[0]).to eq(JSON.parse(invoice1.to_json))
    expect(parsed_response[1]["status"]).to eq(invoice2.status)
    expect(parsed_response).to_not include(JSON.parse(invoice3.to_json))
  end

  it "returns a list of all customer transactions" do
    # GET /api/v1/customers/:id/transactions returns a collection of associated transactions
    customer = create(:customer)
    invoice = create(:invoice)
    invoice.update(customer_id: customer.id)
    transaction1 = create(:transaction)
    transaction2 = create(:transaction)
    transaction3 = create(:transaction)
    invoice.transactions << transaction1
    invoice.transactions << transaction2

    get "/api/v1/customers/#{customer.id}/transactions"

    expect(parsed_response.count).to eq(2)
    expect(parsed_response[0]["id"]).to eq(transaction1.id)
    expect(parsed_response[1]["id"]).to eq(transaction2.id)
    expect(parsed_response).to_not include(JSON.parse(transaction3.to_json))
  end
end
