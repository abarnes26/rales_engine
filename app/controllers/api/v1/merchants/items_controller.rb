class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    render json: Merchant.find_by(merchant_params).items
  end

  private
    def merchant_params
      params.permit(:id)
    end

end
