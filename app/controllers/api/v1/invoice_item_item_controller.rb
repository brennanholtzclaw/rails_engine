class Api::V1::InvoiceItemItemController < ApiController
  respond_to :json

  def show
    respond_with InvoiceItem.find(params[:id]).item
  end
end
