class Api::V1::ItemSalesController < ApiController
  respond_to :json
  def index
    respond_with Item.top_number_sold[0..(params["quantity"].to_i - 1)]
  end
end
