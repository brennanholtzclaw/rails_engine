require 'rails_helper'

RSpec.describe "GET /api/v1/items" do
  def parsed_response
    JSON.parse(response.body)
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
  end

  it "returns a list of all items" do
    merchant1 = create(:merchant, name: "Brennan")
    merchant2 = create(:merchant, name: "John")
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant2.id)
    item3 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items"

    expect(parsed_response.count).to eq(3)

    expect(parsed_response[0]).to eq({
      "id"         => item1.id,
      "name" => item1.name,
      "description" => item1.description,
      "unit_price" => item1.unit_price.to_s,
      "merchant_id" => item1.merchant_id,
      "created_at" => format_date(item1.created_at),
      "updated_at" => format_date(item1.updated_at)
    })

    expect(parsed_response[1]["name"]).to eq(item2.name)
    expect(parsed_response[2]["name"]).to eq(item3.name)
  end

  it "returns just one item by id" do
    merchant1 = create(:merchant, name: "Brennan")
    merchant2 = create(:merchant, name: "John")
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant2.id)
    item3 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items/#{item1.id}"

    expect(parsed_response).to eq({
      "id"         => item1.id,
      "name" => item1.name,
      "description" => item1.description,
      "unit_price" => item1.unit_price.to_s,
      "merchant_id" => item1.merchant_id,
      "created_at" => format_date(item1.created_at),
      "updated_at" => format_date(item1.updated_at)
    })
  end

  it "returns just one item by any criteria" do
    merchant1 = create(:merchant, name: "Brennan")
    merchant2 = create(:merchant, name: "John")
    item1 = create(:item, name: "This Item", merchant_id: merchant1.id)
    item2 = create(:item, name: "That Item", merchant_id: merchant2.id)
    item3 = create(:item, name: "Other Item", merchant_id: merchant1.id)

    get "/api/v1/items/find?id=#{item1.id}"

    expect(parsed_response).to eq({
      "id"         => item1.id,
      "name" => item1.name,
      "description" => item1.description,
      "unit_price" => item1.unit_price.to_s,
      "merchant_id" => item1.merchant_id,
      "created_at" => format_date(item1.created_at),
      "updated_at" => format_date(item1.updated_at)
    })

    get "/api/v1/items/find?name=#{item2.name}"

    expect(parsed_response).to eq({
      "id"         => item2.id,
      "name" => item2.name,
      "description" => item2.description,
      "unit_price" => item2.unit_price.to_s,
      "merchant_id" => item2.merchant_id,
      "created_at" => format_date(item2.created_at),
      "updated_at" => format_date(item2.updated_at)
    })
  end

  it "returns all items by any criteria" do
    merchant1 = create(:merchant, name: "Brennan")
    merchant2 = create(:merchant, name: "John")
    item1 = create(:item, name: "This Item", merchant_id: merchant1.id)
    item2 = create(:item, name: "That Item", merchant_id: merchant2.id)
    item3 = create(:item, name: "Other Item", merchant_id: merchant1.id)

    get "/api/v1/items/find_all?id=#{item1.id}"

    expect(parsed_response.first).to eq({
      "id"         => item1.id,
      "name" => item1.name,
      "description" => item1.description,
      "unit_price" => item1.unit_price.to_s,
      "merchant_id" => item1.merchant_id,
      "created_at" => format_date(item1.created_at),
      "updated_at" => format_date(item1.updated_at)
    })

    get "/api/v1/items/find_all?merchant_id=#{item1.merchant_id}"

    expect(parsed_response.count).to eq(2)

    expect(parsed_response.first["id"]).to eq(item1.id)
    expect(parsed_response.first["merchant_id"]).to eq(item1.merchant_id)
    expect(parsed_response.last["id"]).to eq(item3.id)
    expect(parsed_response.last["merchant_id"]).to eq(item3.merchant_id)
  end
end
