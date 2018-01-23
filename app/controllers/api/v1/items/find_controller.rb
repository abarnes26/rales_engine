class Api::V1::Items::FindController < ApplicationController

  def show
    render json: Customer.find_by(find_params)
  end

  def index
    render json: Customer.where(find_params)
  end

  private

  def find_params
    params.permit(:name, :description, :unit_price, :created_at, :updated_at)
  end

end