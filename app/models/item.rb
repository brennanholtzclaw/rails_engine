class Item < ActiveRecord::Base
  before_validation :convert_unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def convert_unit_price
    self.unit_price = (unit_price.to_f / 100)
  end

  def self.top_number_sold
    joins(invoice_items: :transactions).where(transactions: {result: "success"}).group(:id).order("sum(invoice_items.quantity) desc")
  end

  def self.top_revenue
    joins(invoice_items: :transactions).where(transactions: {result: "success"}).group(:id).order("sum(invoice_items.quantity * invoice_items.unit_price) desc")
  end

end
