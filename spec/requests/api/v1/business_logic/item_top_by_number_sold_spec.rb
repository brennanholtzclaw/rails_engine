require 'rails_helper'

RSpec.describe 'GET /api/v1/items/most_items?quantity=x returns variable amount of top selling items' do
  def parsed_response
    JSON.parse(response.body)
  end

  it 'responds with 2 most frequently sold items' do
    # GET /api/v1/items/most_items?quantity=x returns the top x item instances ranked by total number sold
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice_item1 = create(:invoice_item, quantity: 4)
    invoice_item2 = create(:invoice_item, quantity: 5)
    invoice_item3 = create(:invoice_item, quantity: 6)
    invoice_item4 = create(:invoice_item, quantity: 1)
    transaction1 = create(:transaction, result: "success")
    transaction2 = create(:transaction, result: "success")
    transaction3 = create(:transaction, result: "success")
    transaction4 = create(:transaction, result: "failed")
    invoice1.invoice_items << invoice_item1
    invoice1.invoice_items << invoice_item2
    invoice1.transactions << transaction1
    invoice1.transactions << transaction2
    invoice2.transactions << transaction3
    invoice2.transactions << transaction4
    invoice2.invoice_items << invoice_item3
    invoice2.invoice_items << invoice_item4
    item1.invoices << invoice1 #total qty should be 10
    item2.invoices << invoice2 #total qty should be 7

    get "/api/v1/items/most_items?quantity=2"

    expect(parsed_response.count).to eq(2)
    expect(parsed_response.first).to eq(JSON.parse(item1.to_json))
  end
end
