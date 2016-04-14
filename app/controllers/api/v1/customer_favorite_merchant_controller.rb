class Api::V1::CustomerFavoriteMerchantController < ApiController
  respond_to :json
  def show
    respond_with Customer.favorite_merchant(params["id"])
  end

end
