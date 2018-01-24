class Api::V1::Items::FindController < ApplicationController

  def show
    render json: Item.find_by(find_params)
  end

  def index
    render json: Item.where(find_params)
  end

  def random
    render json: Item.order("RANDOM()").first
  end

  private

  def find_params
    params.permit(:name, :description, :unit_price, :created_at, :updated_at)
  end

end
