class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

   default_scope { order(id: :asc) }

  def self.with_most_revenue(quantity)
    unscoped
    .select("items.*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue")
    .joins(:invoice_items, invoice_items: [:invoice], invoices: [:transactions])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order("revenue DESC")
    .limit(quantity)
  end

  def self.with_most_sales(quantity)
    unscoped
    .joins(:invoice_items, invoice_items: [:invoice], invoices: [:transactions])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order("count(items.id) DESC")
    .limit(quantity)
  end

end
