FactoryGirl.define do
  factory :invoice do
    customer nil
    merchant nil
    status "MyString"
  end
  factory :customer do
    first_name "MyString"
    last_name "MyString"
  end
  factory :merchant do
    name "MyString"
  end
end