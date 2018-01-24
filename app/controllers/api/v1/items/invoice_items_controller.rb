class Api::V1::Items::InvoiceItemsController < ApplicationController

  def show
    render json: Item.find_by(item_params).invoice_items
  end

  private
    def item_params
      params.permit(:id)
    end

end
