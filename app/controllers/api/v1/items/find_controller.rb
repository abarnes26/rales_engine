class Api::V1::Items::FindController < ApplicationController

  def show
    render json: Item.unscoped.find_by(find_params)
  end

  def index
    render json: Item.unscoped.where(find_params)
  end

  def random
    render json: Item.unscoped.order("RANDOM()").first
  end

  private

  def find_params
    if params["unit_price"]
      params["unit_price"]  = params["unit_price"].delete(".")
    end
    params.permit(:name, :description, :unit_price, :created_at, :updated_at, :id, :merchant_id)
  end

end
