class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :unit_price

  belongs_to :invoice
  belongs_to :item
end
