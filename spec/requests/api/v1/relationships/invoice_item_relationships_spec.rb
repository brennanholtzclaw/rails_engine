require 'rails_helper'

RSpec.describe "GET /api/v1/invoice_item relationships" do
  def parsed_response
    JSON.parse(response.body)
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
  end
#   GET /api/v1/invoice_items/:id/item returns the associated item
  it "returns associated invoice_item invoice" do
    # GET /api/v1/invoice_items/:id/invoice returns the associated invoice
    invoice_item1 = create(:invoice_item)
    invoice_item2 = create(:invoice_item)
    invoice = create(:invoice)
    invoice.invoice_items << invoice_item1
    invoice.invoice_items << invoice_item2

    get "/api/v1/invoice_items/#{invoice.id}/invoice"

    expect(parsed_response.count).to eq(1)
    expect(parsed_response[0]["id"]).to eq(invoice.id)
    # expect(parsed_response[1]["id"]).to eq(transaction2.id)
  end
end
