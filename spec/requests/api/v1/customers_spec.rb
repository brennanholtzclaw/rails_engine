require "rails_helper"

RSpec.describe "GET /api/v1/customers" do
  def parsed_response
    JSON.parse(response.body)
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
  end

  it "returns a list of all customers" do
    # id,first_name,last_name,created_at,updated_at
    customer1 = create(:customer, first_name: "Brennan", last_name: "Doe")
    customer2 = create(:customer, first_name: "John", last_name: "Doe")
    customer3 = create(:customer, first_name: "Doe", last_name: "Doe")

    get "/api/v1/customers"

    expect(parsed_response.count).to eq(3)

    expect(parsed_response[0]).to eq({
      "id"         => customer1.id,
      "first_name" => customer1.first_name,
      "last_name" => customer1.last_name,
      "created_at" => format_date(customer1.created_at),
      "updated_at" => format_date(customer1.updated_at)
    })

    expect(parsed_response[1]["first_name"]).to eq(customer2.first_name)
    expect(parsed_response[2]["first_name"]).to eq(customer3.first_name)
  end

  it "returns just one customer by id" do
    customer1 = create(:customer, first_name: "Brennan", last_name: "Doe")
    customer2 = create(:customer, first_name: "John", last_name: "Doe")

    get "/api/v1/customers/#{customer1.id}"

    expect(parsed_response).to eq({
      "id"         => customer1.id,
      "first_name" => customer1.first_name,
      "last_name" => customer1.last_name,
      "created_at" => format_date(customer1.created_at),
      "updated_at" => format_date(customer1.updated_at)
    })

    expect(parsed_response).to_not include(customer2.first_name)
  end

  it "returns just one customer by any criteria" do
    customer1 = create(:customer, first_name: "Brennan", last_name: "Doe")
    customer2 = create(:customer, first_name: "John", last_name: "Doe")

    get "/api/v1/customers/find?id=#{customer1.id}"

    expect(parsed_response).to eq({
      "id"         => customer1.id,
      "first_name" => customer1.first_name,
      "last_name" => customer1.last_name,
      "created_at" => format_date(customer1.created_at),
      "updated_at" => format_date(customer1.updated_at)
    })

    get "/api/v1/customers/find?first_name=#{customer2.first_name}"

    expect(parsed_response).to eq({
      "id"         => customer2.id,
      "first_name" => customer2.first_name,
      "last_name" => customer2.last_name,
      "created_at" => format_date(customer2.created_at),
      "updated_at" => format_date(customer2.updated_at)
    })
  end

  it "returns all customers by any criteria" do
    customer1 = create(:customer, first_name: "Brennan", last_name: "Doe")
    customer2 = create(:customer, first_name: "John", last_name: "Doe")
    customer3 = create(:customer, first_name: "Doe", last_name: "Deer")

    get "/api/v1/customers/find_all?id=#{customer1.id}"

    expect(parsed_response.first).to eq({
      "id"         => customer1.id,
      "first_name" => customer1.first_name,
      "last_name" => customer1.last_name,
      "created_at" => format_date(customer1.created_at),
      "updated_at" => format_date(customer1.updated_at)
    })

    get "/api/v1/customers/find_all?last_name=#{customer1.last_name}"

    expect(parsed_response.count).to eq(2)

    expect(parsed_response.first["id"]).to eq(customer1.id)
    expect(parsed_response.first["first_name"]).to eq(customer1.first_name)
    expect(parsed_response.last["id"]).to eq(customer2.id)
    expect(parsed_response.last["first_name"]).to eq(customer2.first_name)
    expect(parsed_response).to include(JSON.parse(customer2.to_json))
    expect(parsed_response).to_not include(JSON.parse(customer3.to_json))
  end
end
