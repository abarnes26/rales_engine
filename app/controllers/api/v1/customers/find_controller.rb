class Api::V1::Customers::FindController < ApplicationController

  def show
    render json: Customer.find_by(find_params)
  end

  def index
    render json: Customer.where(find_params)
  end

  def random
    render json: Customer.order("RANDOM()").first
  end

  private

  def find_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end

end
