class Api::V1::Transactions::FindController < ApplicationController

  def show
    render json: Customer.find_by(find_params)
  end

  def index
    render json: Customer.where(find_params)
  end

  private

  def find_params
    params.permit(:credit_card_number, :result, :created_at, :updated_at)
  end

end
