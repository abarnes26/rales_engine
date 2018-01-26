class InvoiceItem < ApplicationRecord
  validates_presence_of :item_id, :invoice_id, :quantity, :unit_price
  belongs_to :invoice
  belongs_to :item

  def self.for_invoice(id)
    joins(:invoice)
    .where("invoices.id = ?", id)
  end

end
