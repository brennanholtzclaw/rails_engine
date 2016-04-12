class Api::V1::InvoiceItemsController < ApiController
  respond_to :json

  def show
    respond_with InvoiceItem.find(params[:id])
  end

  def index
    respond_with InvoiceItem.all
  end

  def find
    respond_with InvoiceItem.find_by(params.keys[0] => params.values[0])
  end

  def find_all
    respond_with InvoiceItem.where(params.keys[0] => params.values[0])
  end


  def random
    respond_with InvoiceItem.all.order("RANDOM()").first
  end

  # def find
  #   respond_with InvoiceItem.find_by(invoice_item_params)
  # end
  #
  # def find_all
  #   respond_with InvoiceItem.find_by(invoice_item_params)
  # end
  #
  # private
  #   def invoice_item_params
  #     params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  #     # params.require(:invoice_item).permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  #   end

end
