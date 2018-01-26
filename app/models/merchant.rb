class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  # default_scope { order(:id) }

  def self.favorite_customer(id)
    find_by(id).customers
    .joins(invoices: [:transactions])
    .where(transactions: {result: "success"})
    .group("customers.id")
    .order("count(customers.id) DESC")
    .limit(1)
  end

  def self.revenue_for_single_merchant(id)
    joins(invoices: [:invoice_items, :transactions])
    .where(id)
    .where(transactions: {result: "success"})
    .sum("invoice_items.quantity*invoice_items.unit_price")
  end

  def self.total_revenue_for_date(date)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .where("date(invoices.created_at) = date('#{date}')")
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

end
