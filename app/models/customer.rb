class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name, :updated_at, :created_at
  has_many :invoices

end
