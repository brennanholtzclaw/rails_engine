FactoryGirl.define do

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
