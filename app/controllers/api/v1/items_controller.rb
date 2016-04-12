class Api::V1::ItemsController < ApiController
  respond_to :json

  def show
    respond_with Item.find(params[:id])
  end

  def index
    respond_with Item.all
  end

  def find
    respond_with Item.find_by(params.keys[0] => params.values[0])
  end

  def find_all
    respond_with Item.where(params.keys[0] => params.values[0])
  end
end
