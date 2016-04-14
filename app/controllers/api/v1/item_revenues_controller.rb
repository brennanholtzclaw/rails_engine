class Api::V1::ItemRevenuesController < ApiController
  respond_to :json
  def index
    max = params["quantity"].to_i - 1
    respond_with Item.top_revenue[0..max]
  end
end
