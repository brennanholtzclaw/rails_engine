require "rails_helper"

RSpec.describe "GET /api/v1/merchants/ relationships" do
  def parsed_response
    JSON.parse(response.body)
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
  end

  it "returns a list of all merchant items" do
    merchant1 = create(:merchant, name: "Brennan")
    item1 = create(:item)
    item2 = create(:item)
    merchant1.items << item1
    merchant1.items << item2

    get "/api/v1/merchants/#{merchant1.id}/items"

    expect(parsed_response.count).to eq(2)
    expect(parsed_response[0]).to eq(JSON.parse(item1.to_json))
    expect(parsed_response[1]["name"]).to eq(item2.name)
  end

  it "returns a list of all merchant invoices" do
    merchant1 = create(:merchant, name: "Brennan")
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    merchant1.invoices << invoice1
    merchant1.invoices << invoice2

    get "/api/v1/merchants/#{merchant1.id}/invoices"

    expect(parsed_response.count).to eq(2)
    expect(parsed_response[0]).to eq(JSON.parse(invoice1.to_json))
    expect(parsed_response[1]["created_at"]).to eq(format_date(invoice2.created_at))
  end
end
