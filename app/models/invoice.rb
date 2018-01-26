class Invoice < ApplicationRecord
  validates_presence_of :customer_id, :merchant_id, :status
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  # Invoice.select("invoices.*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoice_items, :transactions).where(transactions: {result: "success"}).group(:id).order("revenue DESC").limit(5)
end
