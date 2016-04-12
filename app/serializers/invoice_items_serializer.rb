class InvoiceItemsSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :invoice_id, :quantity, :formatted_unit_price, :created_at, :updated_at

  def formatted_unit_price
    "#{object.unit_price.to_f / 100}"
  end
end
