class Api::V1::ItemMerchantController < ApiController
  respond_to :json

  def show
    respond_with Item.find(params[:id]).merchant
  end
end
