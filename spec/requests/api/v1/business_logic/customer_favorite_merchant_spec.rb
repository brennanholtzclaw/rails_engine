require 'rails_helper'

RSpec.describe 'GET /customers/:id/favorite_merchant returns merchant with most transactions' do
  def parsed_response
    JSON.parse(response.body)
  end

  it 'responds with merchant for whom the customer has most successful transactions' do
    # GET /api/v1/customers/:id/favorite_merchant returns the merchant who the customer has conducted the most total number of successful transactions with
    merchant = create(:merchant)
    customer1 = create(:customer)
    customer2 = create(:customer)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice_item1 = create(:invoice_item)
    invoice_item2 = create(:invoice_item)
    invoice_item3 = create(:invoice_item)
    invoice_item4 = create(:invoice_item)
    transaction1 = create(:transaction, result: "success")
    transaction2 = create(:transaction, result: "success")
    transaction3 = create(:transaction, result: "success")
    transaction4 = create(:transaction, result: "failed")
    invoice1.invoice_items << invoice_item1
    invoice1.invoice_items << invoice_item2
    invoice1.transactions << transaction1
    invoice1.transactions << transaction2
    invoice2.invoice_items << invoice_item3
    invoice2.invoice_items << invoice_item4
    invoice2.transactions << transaction3
    invoice2.transactions << transaction4
    merchant.invoices << invoice1
    merchant.invoices << invoice2
    customer1.invoices << invoice1
    customer2.invoices << invoice2

    get "/api/v1/customers/#{customer1.id}/favorite_merchant"

    expect(parsed_response["id"]).to eq(merchant.id)
  end
end
