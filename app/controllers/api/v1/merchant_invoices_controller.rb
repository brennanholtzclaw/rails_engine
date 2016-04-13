class Api::V1::MerchantInvoicesController < ApiController
  respond_to :json

  def index
    respond_with Merchant.find(params[:id]).invoices
  end
end
