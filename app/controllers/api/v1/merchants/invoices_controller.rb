class Api::V1::Merchants::InvoicesController < ApplicationController

  def index
    render json: Merchant.find_by(merchant_params).invoices
  end

  private
    def merchant_params
      params.permit(:id)
    end

end
