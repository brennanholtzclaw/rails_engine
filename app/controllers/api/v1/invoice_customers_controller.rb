class Api::V1::InvoiceCustomersController < ApiController
  respond_to :json

  def index
    respond_with Invoice.find(params[:id]).customer
  end
end
