class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name
  has_many :invoices
  has_many :merchants, through: :invoices

  # default_scope { order(id: :DESC) }

  def self.favorite_merchant(id)
    find_by(id).merchants
    .joins(:invoices, invoices: [:transactions])
    .where(transactions: {result: "success"})
    .group("merchants.id")
    .order('count(merchants.id) DESC')
    .limit(1)
  end

end
