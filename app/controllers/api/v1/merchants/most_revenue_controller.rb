class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    render json: Merchant.select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoice_items, :transactions).where(transactions: {result: "success"}).group(:id).order("revenue DESC").limit(quantity_params["quantity"].to_i)
  end

  private

    def quantity_params
      params.permit(:quantity)
    end
end
