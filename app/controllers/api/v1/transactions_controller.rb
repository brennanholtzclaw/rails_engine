class Api::V1::TransactionsController < ApiController
  respond_to :json

  def show
    respond_with Transaction.find(params[:id])
  end

  def index
    respond_with Transaction.all
  end

  def find
    respond_with Transaction.find_by(params.keys[0] => params.values[0])
  end

  def find_all
    respond_with Transaction.where(params.keys[0] => params.values[0])
  end

  def random
    respond_with Transaction.all.order("RANDOM()").first
  end

  # def find
  #   respond_with Transaction.find_by(transaction_params)
  # end
  #
  # def find_all
  #   respond_with Transaction.find_by(transaction_params)
  # end
  # private
  #   def transaction_params
  #     params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  #     params.require(:transaction).permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  #   end

end
