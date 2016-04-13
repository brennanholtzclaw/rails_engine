class Item < ActiveRecord::Base
  before_validation :convert_unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def convert_unit_price
    self.unit_price = (unit_price.to_f / 100)
  end

end
