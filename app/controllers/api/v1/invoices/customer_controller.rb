class Api::V1::Invoices::CustomerController < ApplicationController

  def show
    render json: Invoice.unscoped.find_by(invoice_params).customer
  end

  private
    def invoice_params
      params.permit(:id)
    end

end
