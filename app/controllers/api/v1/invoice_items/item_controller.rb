class Api::V1::InvoiceItems::ItemController < ApplicationController

  def show
    render json: InvoiceItem.find_by(invoice_item_params).item
  end

  private
    def invoice_item_params
      params.permit(:id)
    end

end
