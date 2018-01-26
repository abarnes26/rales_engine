class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    render json: Merchant.favorite_customer(merchant_params)
  end

  private

    def merchant_params
      params.permit(:id)
    end

end
