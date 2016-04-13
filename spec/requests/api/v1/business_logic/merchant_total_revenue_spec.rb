require 'rails_helper'

RSpec.describe it 'GET /merchants/:id/revenue returns total' do
  def parsed_response
    JSON.parse(response.body)
  end

  it 'calling a specific merchant returns total revenue' do
    # GET /api/v1/merchants/:id/revenue
    merchant = create(:merchant)
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

    get "/api/v1/merchants/#{merchant.id}/revenue"

    binding.pry
  end
end
