class Api::V1::CustomerTransactionsController < ApiController
  respond_to :json

  def show
    respond_with Customer.find(params[:id]).transactions
  end
end
