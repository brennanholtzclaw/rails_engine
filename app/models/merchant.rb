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
end
