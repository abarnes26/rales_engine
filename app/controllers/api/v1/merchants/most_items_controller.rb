class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    render json: Merchant.select("merchants.*, items.count AS items_sold").joins(:invoice_items, :items, :transactions).where(transactions: {result: "success"}).group(:id).order("items_sold DESC").limit(quantity_params["quantity"].to_i)
  end

  private

    def quantity_params
      params.permit(:quantity)
    end
end
