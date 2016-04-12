FactoryGirl.define do
  factory :item do
    name "MyString"
    description "MyString"
    unit_price 1
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
