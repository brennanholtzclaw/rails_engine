class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.favorite_merchant(id)
    # Merchant.find(id).invoices.joins(:transactions).where("transactions.result = 'success'").includes(:customer).select("customer.*, COUNT(id) AS count").group("customer.id").order("count desc").first
                                  ####REFACTOR AND OR COME TO UNDERSTAND THIS####
    Merchant.joins(invoices: [:customer]).where("invoices.customer_id = ?", id).select("merchants.*, COUNT(merchants.id) AS count").group("merchants.id").order("count desc").first
  end

end
