require "date"

FactoryBot.define do
  factory :customer do
    first_name "CustomerFirstName"
    last_name "CustomerLasttName"
    created_at "2012-03-27 14:54:09 UTC"
    updated_at "2012-03-27 14:54:09 UTC"
  end
end
