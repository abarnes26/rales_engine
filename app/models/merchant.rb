class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  # default_scope { order(:id) }

  def self.total_revenue_for_date(date)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .where("date(invoices.created_at) = date('#{date}')")
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

end
