FactoryGirl.define do
  factory :transaction do
    invoice nil
    credit_card_number 42424242
    credit_card_expiration_date ""
    result "success"
  end
  factory :invoice_item do
    item nil
    invoice nil
    quantity 10
    unit_price BigDecimal.new("10000")
  end

  sequence :item_name, %w(1 2 3 4).cycle do |num|
    "Item #{num}"
  end

  factory :item do
    name { generate(:item_name) }
    description "Item description"
    unit_price 1000
    merchant nil
  end

  factory :invoice do
    customer nil
    merchant nil
    status "Shipped"
  end

  factory :customer do
    first_name "MyString"
    last_name "MyString"
  end

  factory :merchant do
    name "MyString"
  end
end
