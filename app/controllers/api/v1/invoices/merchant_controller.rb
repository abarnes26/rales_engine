class Api::V1::Invoices::MerchantController < ApplicationController

  def show
    render json: Invoice.find_by(invoice_params).merchant
  end

  private
    def invoice_params
      params.permit(:id)
    end

end
