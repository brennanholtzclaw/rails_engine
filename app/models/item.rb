class Item < ActiveRecord::Base
  before_validation :convert_unit_price

  belongs_to :merchant

  def convert_unit_price
    self.unit_price = (unit_price.to_f / 100)
  end

end
