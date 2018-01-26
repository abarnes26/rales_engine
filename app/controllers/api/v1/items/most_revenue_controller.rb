class Api::V1::Items::MostRevenueController < ApplicationController

  def index
    render json: Item.with_most_revenue(quantity_params["quantity"].to_i)
  end

  private
    def quantity_params
      params.permit(:quantity)
    end

end
