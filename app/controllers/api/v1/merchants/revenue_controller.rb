class Api::V1::Merchants::RevenueController < ApplicationController

  def show
     render json: Merchant.select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoice_items, :transactions).where(merchant_params).where(transactions: {result: "success"}).group(:id)
  end

  private

    def merchant_params
      params.permit(:id)
    end
end
