require 'rails_helper'

describe Item, type: :model do
  describe "Validations" do
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_presence_of(:description)}
    it {is_expected.to validate_presence_of(:unit_price)}
  end

  describe "Relationships" do
    it {is_expected.to belong_to(:merchant)}
    it {is_expected.to have_many(:invoice_items)}
    it {is_expected.to respond_to(:invoices)}
  end

end
