class Api::V1::Customers::TransactionsController < ApplicationController

  def index
    render json: Customer.find_by(customer_params).invoices.joins(:transactions)
  end

  private
    def customer_params
      params.permit(:id)
    end

end
