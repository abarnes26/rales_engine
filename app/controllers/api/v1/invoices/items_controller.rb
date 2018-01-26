class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    render json: Invoice.find_by(invoice_params).items

  end

  private
    def invoice_params
      params.permit(:id)
    end

end
