class MerchantRevenueSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper
  attributes :total_revenue

  def total_revenue
    number_with_precision(object.to_f/100, precision: 2)
  end
end
