class Api::V1::MerchantsController < ApiController
  respond_to :json

  def show
    respond_with Merchant.find(params[:id])
  end

  def index
    respond_with Merchant.all
  end

  def random
    respond_with Merchant.all.order("RANDOM()").first
  end

  def find
    respond_with Merchant.find_by(merchant_params)
  end

  def find_all
    respond_with Merchant.where(merchant_params)
  end

private
  def merchant_params
    params.permit(:id, :name, :item, :created_at, :updated_at)
  end
end
