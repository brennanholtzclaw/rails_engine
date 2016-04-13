class Api::V1::InvoiceMerchantController < ApiController
  respond_to :json

  def show
    respond_with Invoice.find(params[:id]).merchant
  end
end
