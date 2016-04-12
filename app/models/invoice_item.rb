class InvoiceItem < ActiveRecord::Base
  before_validation :convert_unit_price

  belongs_to :item
  belongs_to :invoice

  def convert_unit_price
    self.unit_price = (unit_price.to_f / 100)
  end
end
