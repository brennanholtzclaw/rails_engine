require 'rails_helper'

RSpec.describe "GET /api/v1/item relationships" do
  def parsed_response
    JSON.parse(response.body)
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
  end


  it "returns a collection of item invoice_items" do
    # GET /api/v1/items/:id/invoice_items returns a collection of associated invoice items
    item = create(:item)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice_item1 = create(:invoice_item)
    invoice_item2 = create(:invoice_item)
    invoice_item1.update(item: item)
    invoice_item2.update(item: item)
    invoice1.invoice_items << invoice_item1
    invoice2.invoice_items << invoice_item2

    get "/api/v1/items/#{item.id}/invoice_items"

    expect(parsed_response.count).to eq(2)
    expect(parsed_response[0]).to eq(JSON.parse(invoice_item1.to_json))
    expect(parsed_response[1]["id"]).to eq(invoice_item2.id)
  end

  it "returns associated item merchant" do
    item = create(:item)
    merchant = create(:merchant)
    merchant.items << item

    get "/api/v1/items/#{item.id}/merchant"

    expect(parsed_response).to eq(JSON.parse(merchant.to_json))
  end
end
