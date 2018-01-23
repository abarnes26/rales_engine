class Api::V1::InvoiceItems::FindController < ApplicationController

  def show
    render json: InvoiceItems.find_by(find_params)
  end

  def index
    render json: InvoiceItems.where(find_params)
  end

  private

  def find_params
    params.permit(:quantity, :unit_price, :created_at, :updated_at)
  end

end
