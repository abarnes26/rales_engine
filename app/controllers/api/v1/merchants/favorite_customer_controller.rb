class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    # render json: Customer.find_by(customer_params).merchants.joins(:invoices, invoices: [:transactions]).where(transactions: {result: "success"}).group("merchants.id").order('count(merchants.id) DESC').limit(1)

    # binding.pry
    render json: Merchant.find_by(merchant_params).customers.joins(:invoices, invoices: [:transactions]).where(transactions: {result: "success"}).group("customers.id").order("count(customers.id) DESC").limit(1)
  end

  private

    def merchant_params
      params.permit(:id)
    end

end
