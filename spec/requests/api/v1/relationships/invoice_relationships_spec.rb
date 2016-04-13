require 'rails_helper'

RSpec.describe "GET /api/v1/invoices relationships" do
  def parsed_response
    JSON.parse(response.body)
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
  end
  # GET /api/v1/invoices/:id/customer returns the associated customer
  # GET /api/v1/invoices/:id/merchant returns the associated merchant
  it "returns a list of all invoice transactions" do
    # GET /api/v1/invoices/:id/transactions returns a collection of associated transactions
    invoice = create(:invoice)
    transaction1 = create(:transaction)
    transaction2 = create(:transaction)
    invoice.transactions << transaction1
    invoice.transactions << transaction2

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(parsed_response.count).to eq(2)
    expect(parsed_response[0]["id"]).to eq(transaction1.id)
    expect(parsed_response[1]["id"]).to eq(transaction2.id)
  end

  it "returns a list of all invoice invoice items" do
    # GET /api/v1/invoices/:id/invoice_items returns a collection of associated invoice items
    invoice = create(:invoice)
    invoice_item1 = create(:invoice_item)
    invoice_item2 = create(:invoice_item)
    invoice.invoice_items << invoice_item1
    invoice.invoice_items << invoice_item2

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(parsed_response.count).to eq(2)
    expect(parsed_response[0]["id"]).to eq(invoice_item1.id)
    expect(parsed_response[0]["id"]).to_not eq(invoice_item2.id)
    expect(parsed_response[1]["id"]).to eq(invoice_item2.id)
  end

  it "returns a list of all invoice items" do
    # GET /api/v1/invoices/:id/items returns a collection of associated items
    invoice = create(:invoice)
    invoice_item1 = create(:invoice_item)
    invoice_item2 = create(:invoice_item)
    invoice.invoice_items << invoice_item1
    invoice.invoice_items << invoice_item2

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(parsed_response.count).to eq(2)
    expect(parsed_response[0]["id"]).to eq(invoice_item1.id)
    expect(parsed_response[0]["id"]).to_not eq(invoice_item2.id)
    expect(parsed_response[1]["id"]).to eq(invoice_item2.id)
  end
end
