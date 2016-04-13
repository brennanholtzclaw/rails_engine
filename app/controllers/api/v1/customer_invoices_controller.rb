class Api::V1::CustomerInvoicesController < ApiController
  respond_to :json

  def show
    respond_with Customer.find(params[:id]).invoices
  end
end
