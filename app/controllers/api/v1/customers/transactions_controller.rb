class Api::V1::Customers::TransactionsController < ApplicationController

  def index
    render json: Transaction.for_customer(customer_params["id"])
  end

  private
    def customer_params
      params.permit(:id)
    end

end
