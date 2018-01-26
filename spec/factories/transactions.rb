require "date"

FactoryBot.define do
  factory :transaction do
    credit_card_number "FakeNumer"
    credit_card_expiration_date "FakeExpDate"
    result "success"
    invoice
    created_at "2012-03-27 14:54:09 UTC"
    updated_at "2012-03-27 14:54:09 UTC"
  end
end
