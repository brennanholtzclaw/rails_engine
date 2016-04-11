require 'rails_helper'

RSpec.describe CustomersController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #find" do
    it "returns http success" do
      get :find
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #find_all" do
    it "returns http success" do
      get :find_all
      expect(response).to have_http_status(:success)
    end
  end

end
