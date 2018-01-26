class Api::V1::Invoices::InvoiceItemsController < ApplicationController

  def show
    render json: InvoiceItem.for_invoice(invoice_params["id"])
  end

  private
    def invoice_params
      params.permit(:id)
    end


end
