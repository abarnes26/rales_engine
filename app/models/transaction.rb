class Transaction < ApplicationRecord
  validates_presence_of :invoice_id, :credit_card_number, :result
  belongs_to :invoice

  # default_scope { order(id: :asc) }

  # scope :successful, -> { where(result: 'success') }
  # scope :unsuccessful, -> { where(result: 'not_successful')}

  def self.for_customer(id)
    joins(invoice: [:customer])
    .where("customers.id = ?", id)
  end

end
