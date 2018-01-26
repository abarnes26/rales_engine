class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :unit_price, :invoice_id, :item_id

  def unit_price
    (object["unit_price"].to_f/100).round(2).to_s
  end
end
