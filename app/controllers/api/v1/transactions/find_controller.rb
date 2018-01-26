class Api::V1::Transactions::FindController < ApplicationController

  def show
    render json: Transaction.find_by(find_params)
  end

  def index
    render json: Transaction.where(find_params)
  end

  def random
    render json: Transaction.order("RANDOM()").first
  end

  private

  def find_params
    params.permit(:credit_card_number, :result, :created_at, :updated_at, :id, :invoice_id)
  end

end
