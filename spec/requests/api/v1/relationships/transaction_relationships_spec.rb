require 'rails_helper'

RSpec.describe "GET /api/v1/transactions relationships" do
  def parsed_response
    JSON.parse(response.body)
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
  end


  it "returns the associated transaction invoice" do
    # GET /api/v1/transactions/:id/invoice returns the associated invoice
    transaction1 = create(:transaction)
    transaction2 = create(:transaction)
    invoice = create(:invoice)
    invoice2 = create(:invoice)
    invoice.transactions << transaction1
    invoice.transactions << transaction2

    get "/api/v1/transactions/#{transaction1.id}/invoice"

    expect(parsed_response).to eq(JSON.parse(invoice.to_json))
    expect(parsed_response).to_not eq(JSON.parse(invoice2.to_json))

    get "/api/v1/transactions/#{transaction2.id}/invoice"

    expect(parsed_response).to eq(JSON.parse(invoice.to_json))
    expect(parsed_response).to_not eq(JSON.parse(invoice2.to_json))
  end
end
