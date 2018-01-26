class Api::V1::Items::MerchantController < ApplicationController

  def show
    render json: Item.find_by(item_params).merchant
  end

  private
    def item_params
      params.permit(:id)
    end

end
