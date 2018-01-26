class Api::V1::Items::MostItemsController < ApplicationController

  def index
    render json: Item.with_most_sales(quantity_params["quantity"].to_i)
  end

  private
    def quantity_params
      params.permit(:quantity)
    end

end
