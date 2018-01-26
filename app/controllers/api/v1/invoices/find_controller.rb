class Api::V1::Invoices::FindController < ApplicationController

  def show
    render json: Invoice.find_by(find_params)
  end

  def index
    render json: Invoice.where(find_params)
  end

  def random
    render json: Invoice.order("RANDOM()").first
  end

  private

  def find_params
    params.permit(:status, :created_at, :updated_at, :id, :merchant_id, :customer_id)
  end

end
