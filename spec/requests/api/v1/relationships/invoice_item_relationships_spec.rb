require 'rails_helper'

RSpec.describe "GET /api/v1/invoice_item relationships" do
  def parsed_response
    JSON.parse(response.body)
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
  end

  it "returns associated invoice_item invoice" do
    # GET /api/v1/invoice_items/:id/invoice returns the associated invoice
    invoice_item1 = create(:invoice_item)
    invoice_item2 = create(:invoice_item)
    invoice = create(:invoice)
    invoice.invoice_items << invoice_item1
    invoice.invoice_items << invoice_item2

    get "/api/v1/invoice_items/#{invoice_item1.id}/invoice"

    expect(parsed_response).to eq(JSON.parse(invoice.to_json))
  end

  it "returns associated invoice_item item" do
    # GET /api/v1/invoice_items/:id/item returns the associated item
    invoice_item = create(:invoice_item)
    item = create(:item)
    invoice_item.update(item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expect(parsed_response).to eq(JSON.parse(item.to_json))
  end
end
