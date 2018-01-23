FactoryBot.define do
  factory :invoice do
    status "success"
    merchant
    customer
  end
end
