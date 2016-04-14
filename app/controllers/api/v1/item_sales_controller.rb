class Api::V1::ItemSalesController < ApiController
  respond_to :json
  def index
    max = (params["quantity"].to_i - 1)
    respond_with Item.top_number_sold[0..max]
  end
end
