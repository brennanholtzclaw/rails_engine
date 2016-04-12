class Api::V1::CustomersController < ApiController
  respond_to :json

  def show
    respond_with Customer.find(params[:id])
  end

  def index
    respond_with Customer.all
  end

  def find
    respond_with Customer.find_by(params.keys[0] => params.values[0])
  end

  def find_all
    respond_with Customer.where(params.keys[0] => params.values[0])
  end

  def random
    respond_with Customer.all.order("RANDOM()").first
  end

  # def find
  #   respond_with Customer.find_by(customer_params)
  # end
  #
  # def find_all
  #   respond_with Customer.find_by(customer_params)
  # end
  #
  # private
  #   def customer_params
  #     params.permit(:first_name, :last_name, :created_at, :updated_at)
  #     # params.require(:customer).permit(:first_name, :last_name, :created_at, :updated_at)
  #   end
end
