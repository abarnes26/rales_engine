FactoryBot.define do
  factory :invoice_item do
    quantity 5
    unit_price 100
    invoice
    item
  end
end
