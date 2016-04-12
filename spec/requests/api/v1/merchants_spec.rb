require "rails_helper"

RSpec.describe "GET /api/v1/merchants" do
  def parsed_response
    JSON.parse(response.body)
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
  end

  it "returns a list of all merchants" do
    merchant1 = create(:merchant, name: "Brennan")
    merchant2 = create(:merchant, name: "John")
    merchant3 = create(:merchant, name: "Doe")

    get "/api/v1/merchants"

    expect(parsed_response.count).to eq(3)

    expect(parsed_response[0]).to eq({
      "id"         => merchant1.id,
      "name" => merchant1.name,
      "created_at" => format_date(merchant1.created_at),
      "updated_at" => format_date(merchant1.updated_at)
    })

    expect(parsed_response[1]["name"]).to eq(merchant2.name)
    expect(parsed_response[2]["name"]).to eq(merchant3.name)
  end

  it "returns just one merchant by id" do
    merchant1 = create(:merchant, name: "Brennan")
    merchant2 = create(:merchant, name: "John")

    get "/api/v1/merchants/#{merchant1.id}"

    expect(parsed_response).to eq({
      "id"         => merchant1.id,
      "name" => merchant1.name,
      "created_at" => format_date(merchant1.created_at),
      "updated_at" => format_date(merchant1.updated_at)
    })

    expect(parsed_response).to_not include(merchant2.name)
  end

  it "returns just one merchant by any criteria" do
    merchant1 = create(:merchant, name: "Brennan")
    merchant2 = create(:merchant, name: "John")


    get "/api/v1/merchants/find?id=#{merchant1.id}"

    expect(parsed_response).to eq({
      "id"         => merchant1.id,
      "name" => merchant1.name,
      "created_at" => format_date(merchant1.created_at),
      "updated_at" => format_date(merchant1.updated_at)
      })

    get "/api/v1/merchants/find?name=#{merchant2.name}"

    expect(parsed_response).to eq({
      "id"         => merchant2.id,
      "name" => merchant2.name,
      "created_at" => format_date(merchant2.created_at),
      "updated_at" => format_date(merchant2.updated_at)
      })
  end

  it "returns all merchants by any criteria" do
    merchant1 = create(:merchant, name: "Brennan")
    merchant2 = create(:merchant, name: "Brennan")
    merchant3 = create(:merchant, name: "John")

    get "/api/v1/merchants/find_all?id=#{merchant1.id}"

    expect(parsed_response.first).to eq({
      "id"         => merchant1.id,
      "name" => merchant1.name,
      "created_at" => format_date(merchant1.created_at),
      "updated_at" => format_date(merchant1.updated_at)
      })

    get "/api/v1/merchants/find_all?name=#{merchant2.name}"

    expect(parsed_response.count).to eq(2)

    expect(parsed_response.first["id"]).to eq(merchant1.id)
    expect(parsed_response.first["name"]).to eq(merchant1.name)
    expect(parsed_response.last["id"]).to eq(merchant2.id)
    expect(parsed_response.last["name"]).to eq(merchant2.name)
  end
end
