require 'rails_helper'

describe "Invoices API" do
  context "HTTP GET" do
    it "sends a list of invoices" do
      create_list(:invoice, 3)

      get '/api/v1/invoices'

      expect(response).to be_success

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(3)
    end

    it "sends a single invoice" do
      id = create(:invoice).id

      get "/api/v1/invoices/#{id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["id"]).to eq(id)
    end
  end
end
