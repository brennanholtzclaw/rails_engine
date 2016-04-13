class Api::V1::MerchantCustomerPendingsController < ApiController
  respond_to :json
  def index
    respond_with Merchant.customers_with_pending_invoices(params["id"])
  end

end
