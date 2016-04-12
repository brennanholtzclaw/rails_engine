class Api::V1::ItemsController < ApiController
  respond_to :json

  def show
    respond_with Item.find(params[:id])
  end

  def index
    respond_with Item.all
  end

  def find
    respond_with Item.find_by(params.keys[0] => params.values[0])
  end

  def find_all
    respond_with Item.where(params.keys[0] => params.values[0])
  end

  def random
    respond_with Item.all.order("RANDOM()").first
  end

  # def find
  #   respond_with Item.find_by(item_params)
  # end
  #
  # def find_all
  #   respond_with Item.find_by(item_params)
  # end
  #
  # private
  #   def item_params
  #     # params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  #     params.require(:item).permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  #   end
end
