require 'rails_helper'

describe Item, type: :model do
  # describe "Validations" do
  #   it {is_expected.to validate_presence_of(:name)}
  #   it {is_expected.to validate_presence_of(:description)}
  #   it {is_expected.to validate_presence_of(:price)}
  #   it {is_expected.to validate_presence_of(:image)}
  # end

  describe "Relationships" do
    it {is_expected.to belong_to(:merchant)}
    it {is_expected.to have_many(:invoiceitems)}
    it {is_expected.to have_many(:invoices)}
  end

end
