class Api::V1::TransactionsController < ApiController
  respond_to :json

  def show
    respond_with Transaction.find(params[:id])
  end

  def index
    respond_with Transaction.all
  end

  def random
    respond_with Transaction.all.order("RANDOM()").first
  end

  def find
    respond_with Transaction.find_by(transaction_params)
  end

  def find_all
    respond_with Transaction.where(transaction_params)
  end

private
  def transaction_params
    params.permit(:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at)
  end
end
