class MerchantSerializer < ActiveModel::Serializer
  attributes :id, :name
  # attribute :revenue, if: :revenue

  has_many :items
  has_many :invoices
  #
  # def revenue?
  #   true if object.revenue
  # end

end
