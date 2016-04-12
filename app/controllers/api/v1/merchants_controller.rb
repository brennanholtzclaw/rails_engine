class Api::V1::MerchantsController < ApiController
  respond_to :json

  def show
    respond_with Merchant.find(params[:id])
  end

  def index
    respond_with Merchant.all
  end

  def find
    # @merchant = Merchant.find_by
  end

  def find_all
    # @merchants = Merchant.where
  end

  def create(merchant_params)
  end

  def update(merchant_params)
  end

# private
  # def merchant_params
  #   params.require(:merchant).permit(:name)
  # end
end
