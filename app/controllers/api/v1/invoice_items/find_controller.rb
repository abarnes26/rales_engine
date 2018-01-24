class Api::V1::InvoiceItems::FindController < ApplicationController

  def show
    render json: InvoiceItem.find_by(find_params)
  end

  def index
    render json: InvoiceItem.where(find_params)
  end

  def random
    render json: InvoiceItem.order("RANDOM()").first
  end

  private

  def find_params
    params.permit(:quantity, :unit_price, :created_at, :updated_at)
  end

end
