class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def self.total_revenue(id)
    revenue = Merchant.find(id).invoices.joins(:transactions).where("transactions.result = 'success'").joins(:invoice_items).sum("unit_price * quantity")
    return {"revenue" => revenue}
  end

end
