class Api::V1::InvoiceCustomerController < ApiController
  respond_to :json

  def show
    respond_with Invoice.find(params[:id]).customer
  end
end
