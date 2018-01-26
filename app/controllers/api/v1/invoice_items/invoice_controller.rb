class Api::V1::InvoiceItems::InvoiceController < ApplicationController

  def show
    render json: InvoiceItem.find_by(invoice_item_params).invoice
  end

  private
    def invoice_item_params
      params.permit(:id)
    end

end
