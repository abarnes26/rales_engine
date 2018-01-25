FactoryBot.define do
  factory :item do
    name "ItemName"
    description "ItemDescription"
    unit_price 100
    merchant
  end
end
