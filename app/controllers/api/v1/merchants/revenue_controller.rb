class Api::V1::Merchants::RevenueController < ApplicationController

  def show
     render json: Merchant.unscoped.revenue_for_single_merchant(merchant_params), serializer: MerchantRevenueSerializer
  end

  private

    def merchant_params
      params.permit(:id)
    end
end
