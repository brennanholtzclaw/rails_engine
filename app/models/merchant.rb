class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def self.total_revenue(id)
    revenue = Merchant.find(id).invoices.joins(:transactions).where("transactions.result = 'success'").joins(:invoice_items).sum("unit_price * quantity")
    return {"revenue" => revenue}
  end

  def self.customers_with_pending_invoices(id)
    Merchant.find(id).invoices.includes(:customer).joins(:transactions).where("transactions.result = 'failed'").uniq
  end

  def self.favorite_customer(id)
    # Merchant.find(id).invoices.joins(:transactions).where("transactions.result = 'success'").includes(:customer).select("customer.*, COUNT(id) AS count").group("customer.id").order("count desc").first
                                  ####REFACTOR AND OR COME TO UNDERSTAND THIS####
    Customer.joins(invoices: [:merchant]).where("invoices.merchant_id = ?", id).select("customers.*, COUNT(customers.id) AS count").group("customers.id").order("count desc").first
  end
end
