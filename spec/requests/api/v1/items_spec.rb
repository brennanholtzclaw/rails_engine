require 'rails_helper'

RSpec.describe "GET /api/v1/items" do
  def parsed_response
    JSON.parse(response.body)
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
  end

  it "returns a list of all items" do
    # id,name,description,unit_price,merchant_id,created_at,updated_at

    item1 = create(:item, first_name: "Brennan", last_name: "Doe")
    item2 = create(:item, first_name: "John", last_name: "Doe")
    item3 = create(:item, first_name: "Doe", last_name: "Doe")

    get "/api/v1/items"

    expect(parsed_response.count).to eq(3)

    expect(parsed_response[0]).to eq({
      "id"         => item1.id,
      "first_name" => item1.first_name,
      "last_name" => item1.last_name,
      "created_at" => format_date(item1.created_at),
      "updated_at" => format_date(item1.updated_at)
    })

    expect(parsed_response[1]["first_name"]).to eq(item2.first_name)
    expect(parsed_response[2]["first_name"]).to eq(item3.first_name)
  end

  it "returns just one item by id" do
    item1 = create(:item, first_name: "Brennan", last_name: "Doe")
    item2 = create(:item, first_name: "John", last_name: "Doe")

    get "/api/v1/items/#{item1.id}"

    expect(parsed_response).to eq({
      "id"         => item1.id,
      "first_name" => item1.first_name,
      "last_name" => item1.last_name,
      "created_at" => format_date(item1.created_at),
      "updated_at" => format_date(item1.updated_at)
    })

    expect(parsed_response).to_not include(item2.first_name)
  end

  it "returns just one item by any criteria" do
    item1 = create(:item, first_name: "Brennan", last_name: "Doe")
    item2 = create(:item, first_name: "John", last_name: "Doe")

    get "/api/v1/items/find?id=#{item1.id}"

    expect(parsed_response).to eq({
      "id"         => item1.id,
      "first_name" => item1.first_name,
      "last_name" => item1.last_name,
      "created_at" => format_date(item1.created_at),
      "updated_at" => format_date(item1.updated_at)
    })

    get "/api/v1/items/find?first_name=#{item2.first_name}"

    expect(parsed_response).to eq({
      "id"         => item2.id,
      "first_name" => item2.first_name,
      "last_name" => item2.last_name,
      "created_at" => format_date(item2.created_at),
      "updated_at" => format_date(item2.updated_at)
    })

### HOW TO HANDLE MULTIPLE RESULTS IN FIND METHOD ###
    # get "/api/v1/items/find?last_name=#{item2.last_name}"
    #
    # expect(parsed_response).to eq({
    #   "id"         => item2.id,
    #   "first_name" => item2.first_name,
    #   "last_name" => item2.last_name,
    #   "created_at" => format_date(item2.created_at),
    #   "updated_at" => format_date(item2.updated_at)
    # })
  end

  it "returns all items by any criteria" do
    item1 = create(:item, first_name: "Brennan", last_name: "Doe")
    item2 = create(:item, first_name: "John", last_name: "Doe")
    item3 = create(:item, first_name: "Doe", last_name: "Deer")

    get "/api/v1/items/find_all?id=#{item1.id}"

    expect(parsed_response.first).to eq({
      "id"         => item1.id,
      "first_name" => item1.first_name,
      "last_name" => item1.last_name,
      "created_at" => format_date(item1.created_at),
      "updated_at" => format_date(item1.updated_at)
    })

    get "/api/v1/items/find_all?last_name=#{item1.last_name}"

    expect(parsed_response.count).to eq(2)

    expect(parsed_response.first["id"]).to eq(item1.id)
    expect(parsed_response.first["first_name"]).to eq(item1.first_name)
    expect(parsed_response.last["id"]).to eq(item2.id)
    expect(parsed_response.last["first_name"]).to eq(item2.first_name)
    expect(parsed_response).to include(JSON.parse(item2.to_json))
    expect(parsed_response).to_not include(JSON.parse(item3.to_json))
  end
end

end
