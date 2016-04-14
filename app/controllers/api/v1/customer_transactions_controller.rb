class Api::V1::CustomerTransactionsController < ApiController
  respond_to :json

  def index
    respond_with Customer.find(params[:id]).transactions
  end
end
