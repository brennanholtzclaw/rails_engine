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
end
