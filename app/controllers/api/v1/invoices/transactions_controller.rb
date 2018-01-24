class Api::V1::Invoices::TransactionsController < ApplicationController

  def index
    render json: Invoice.find_by(invoice_params).transactions
  end

  private
    def invoice_params
      params.permit(:id)
    end

end
