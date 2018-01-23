FactoryBot.define do
  factory :invoice_item do
    quantity 5
    unit_price 10.0
    invoice
    item
  end
end
