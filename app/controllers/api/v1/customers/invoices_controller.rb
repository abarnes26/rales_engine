class Api::V1::Customers::InvoicesController < ApplicationController

  def index
    render json: Customer.find_by(customer_params).invoices
  end

  private
    def customer_params
      params.permit(:id)
    end

end
