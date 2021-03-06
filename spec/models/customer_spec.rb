require 'rails_helper'

describe Customer, type: :model do
  describe "Validations" do
    it {is_expected.to validate_presence_of(:first_name)}
    it {is_expected.to validate_presence_of(:last_name)}
  end

  describe "Relationships" do
    it {is_expected.to have_many(:invoices)}
  end

end
