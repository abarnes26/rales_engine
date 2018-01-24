class Api::V1::Transactions::InvoiceController < ApplicationController

  def show
    render json: Transaction.find_by(transaction_params).invoices
  end

  private
    def transaction_params
      params.permit(:id)
    end

end
