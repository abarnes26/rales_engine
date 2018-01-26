class Api::V1::Invoices::InvoiceItemsController < ApplicationController

  def show
    render json: InvoiceItem.joins(:invoice).where("invoices.id = ?", invoice_params["id"])
    # render json: Invoice.find_by(invoice_params).invoice_items
  end

  private
    def invoice_params
      params.permit(:id)
    end


end
