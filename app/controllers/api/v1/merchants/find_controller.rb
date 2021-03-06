class Api::V1::Merchants::FindController < ApplicationController

  def show
    render json: Merchant.find_by(find_params)
  end

  def index
    render json: Merchant.where(find_params)
  end

  def random
    render json: Merchant.order("RANDOM()").first
  end

  private

  def find_params
    params.permit(:name, :created_at, :updated_at, :id)
  end

end
