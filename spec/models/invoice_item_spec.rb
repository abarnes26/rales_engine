require 'rails_helper'

describe InvoiceItem, type: :model do
  describe "Validations" do
    it {is_expected.to validate_presence_of(:item_id)}
    it {is_expected.to validate_presence_of(:invoice_id)}
    it {is_expected.to validate_presence_of(:quantity)}
    it {is_expected.to validate_presence_of(:unit_price)}
  end

  describe "Relationships" do
    it {is_expected.to belong_to(:invoice)}
    it {is_expected.to belong_to(:item)}
  end

end
