class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def show
    render json: Customer.find_by(customer_params).merchants.joins(:invoices, invoices: [:transactions]).where(transactions: {result: "success"}).group("merchants.id").order('count(merchants.id) DESC').limit(1)
    # render json: Merchant.select.joins(:invoices, invoices: [:transactions, :customer]).where(customers: {id: "4"}).where(transactions: {result: "success"}).group("merchants.id").order("count DESC").limit(1)
    # render json: Customer.select("merchants.*").joins(:merchants, :invoices, invoices: [:transactions]).where(customer_params).where(transactions: {result: "success"}).group("merchants.id").order('count(merchants.id) DESC').limit(1)
  end


  private
    def customer_params
      params.permit(:id)
    end

end
