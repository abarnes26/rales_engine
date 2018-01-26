require "date"

FactoryBot.define do
  factory :item do
    name "ItemName"
    description "ItemDescription"
    unit_price 100
    merchant
    created_at "2012-03-27 14:54:09 UTC"
    updated_at "2012-03-27 14:54:09 UTC"
  end
end
