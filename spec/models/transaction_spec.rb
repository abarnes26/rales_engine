require 'rails_helper'

describe Transaction, type: :model do
  describe "Validations" do
    it {is_expected.to validate_presence_of(:invoice_id)}
    it {is_expected.to validate_presence_of(:credit_card_number)}
    it {is_expected.to validate_presence_of(:result)}
  end

  describe "Relationships" do
    it {is_expected.to belong_to(:invoice)}
  end

end
