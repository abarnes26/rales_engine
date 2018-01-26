class Api::V1::InvoiceItems::FindController < ApplicationController

  def show
    render json: InvoiceItem.unscoped.find_by(find_params)
  end

  def index
    render json: InvoiceItem.unscoped.where(find_params)
  end

  def random
    render json: InvoiceItem.unscoped.order("RANDOM()").first
  end

  private

  def find_params
    if params["unit_price"]
      params["unit_price"]  = params["unit_price"].delete(".")
    end
    params.permit(:quantity, :unit_price, :created_at, :updated_at, :invoice_id, :item_id, :id)
  end

end
