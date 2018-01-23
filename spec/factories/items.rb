FactoryBot.define do
  factory :item do
    name "ItemName"
    description "ItemDescription"
    unit_price 100.00
    merchant
  end
end
