require 'rails_helper'

describe Merchant, type: :model do
  describe "Validations" do
    it {is_expected.to validate_presence_of(:name)}
  end

  describe "Relationships" do
    it {is_expected.to have_many(:items)}
    it {is_expected.to have_many(:invoices)}
  end

end
