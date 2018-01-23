class Api::V1::Invoices::FindController < ApplicationController

  def show
    render json: Customer.find_by(find_params)
  end

  def index
    render json: Customer.where(find_params)
  end

  private

  def find_params
    params.permit(:status, :created_at, :updated_at)
  end

end