class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices
  def self.favorite_merchant(id)
    Customer.find(id).merchants.joins(:transactions).where(transactions: { result: 'success'}).group(:id).order('transactions.count desc').first
  end

end
