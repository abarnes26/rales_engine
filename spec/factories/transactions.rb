FactoryBot.define do
  factory :transaction do
    credit_card_number "FakeNumer"
    credit_card_expiration_date "FakeExpDate"
    result "success"
    invoice
  end
end
