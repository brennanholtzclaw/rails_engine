class Api::V1::MerchantRevenueController < ApiController
  respond_to :json
  def show
    respond_with Merchant.total_revenue(params["id"])
  end
end
