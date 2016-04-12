class Api::V1::InvoicesController < ApiController
  respond_to :json

  def show
    respond_with Invoice.find(params[:id])
  end

  def index
    respond_with Invoice.all
  end

  def find
    respond_with Invoice.find_by(params.keys[0] => params.values[0])
  end

  def find_all
    respond_with Invoice.where(params.keys[0] => params.values[0])
  end

  def random
    respond_with Invoice.all.order("RANDOM()").first
  end
end
