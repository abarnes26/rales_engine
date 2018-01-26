class Api::V1::Items::MostItemsController < ApplicationController

  def index
    render json: Item.unscoped.joins(:invoice_items, invoice_items: [:invoice], invoices: [:transactions]).where(transactions: {result: 'success'}).group(:id).order("count(items.id) DESC").limit(2)
  end

  private
    def quantity_params
      params.permit(:quantity)
    end

end
