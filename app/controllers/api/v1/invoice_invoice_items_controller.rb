class Api::V1::InvoiceInvoiceItemsController < ApiController
  respond_to :json

  def index
    respond_with Invoice.find(params[:id]).invoice_items
  end
end
