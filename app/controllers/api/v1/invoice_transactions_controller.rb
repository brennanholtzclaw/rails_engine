class Api::V1::InvoiceTransactionsController < ApiController
  respond_to :json

  def index
    respond_with Invoice.find(params[:id]).transactions
  end
end
