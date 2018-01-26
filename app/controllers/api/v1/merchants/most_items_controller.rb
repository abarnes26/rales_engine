class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    render json: Merchant.items_with_most_sales(quantity_params["quantity"].to_i)
  end

  private

    def quantity_params
      params.permit(:quantity)
    end
end
