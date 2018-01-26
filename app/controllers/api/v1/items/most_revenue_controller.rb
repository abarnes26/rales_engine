class Api::V1::Items::MostRevenueController < ApplicationController

  def index
    render json: Item.unscoped.select("items.*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoice_items, invoice_items: [:invoice], invoices: [:transactions]).where(transactions: {result: 'success'}).group(:id).order("revenue DESC").limit(quantity_params["quantity"].to_i)
  end

  private
    def quantity_params
      params.permit(:quantity)
    end

end
