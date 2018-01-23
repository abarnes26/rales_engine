require 'rails_helper'

describe Invoice, type: :model do
  describe "Validations" do
    it {is_expected.to validate_presence_of(:customer_id)}
    it {is_expected.to validate_presence_of(:merchant_id)}
    it {is_expected.to validate_presence_of(:status)}
  end

  describe "Relationships" do
    it {is_expected.to have_many(:transactions)}
    it {is_expected.to have_many(:invoice_items)}
    it {is_expected.to have_many(:items)}
    it {is_expected.to belong_to(:customer)}
    it {is_expected.to belong_to(:merchant)}
  end

end
