class Api::V1::Merchants::RevenueByDateController < ApplicationController

  def show
      render json: Merchant.total_revenue_for_date(date_params["date"]), serializer: MerchantRevenueSerializer
  end

  private
    def date_params
      params.permit(:date)
    end

end
