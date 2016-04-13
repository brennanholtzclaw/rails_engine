class Api::V1::InvoiceItemInvoiceController < ApiController
  respond_to :json

  def show
    respond_with InvoiceItem.find(params[:id]).invoice
  end
end
