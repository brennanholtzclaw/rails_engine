require 'rails_helper'

RSpec.describe 'GET /merchants/:id/customers_with_pending_invoices returns expected' do
  def parsed_response
    JSON.parse(response.body)
  end

  it 'responds with collection of customers with pending invoices' do
    # GET /api/v1/merchants/:id/customers_with_pending_invoices returns a collection of customers which have pending (unpaid) invoices
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
    transaction3 = create(:transaction, result: "success")
    transaction4 = create(:transaction, result: "failed")
    invoice1.invoice_items << invoice_item1
    invoice1.invoice_items << invoice_item2
    invoice1.transactions << transaction1
    invoice2.invoice_items << invoice_item3
    invoice2.invoice_items << invoice_item4
    invoice2.transactions << transaction3
    invoice2.transactions << transaction4
    merchant.invoices << invoice1
    merchant.invoices << invoice2
    customer1.invoices << invoice1
    customer2.invoices << invoice2

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

    expect(parsed_response.count).to eq(1)
  end
end
