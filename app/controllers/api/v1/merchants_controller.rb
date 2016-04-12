class Api::V1::MerchantsController < ApiController
  respond_to :json

  def show
    respond_with Merchant.find(params[:id])
  end

  def index
    respond_with Merchant.all
  end

  def find
    respond_with Merchant.find_by(params.keys[0] => params.values[0])
  end

  def find_all
    respond_with Merchant.where(params.keys[0] => params.values[0])
  end

  def random
    respond_with Merchant.all.order("RANDOM()").first
  end
# private
  # def merchant_params
  #   params.require(:merchant).permit(:name)
  # end
end
