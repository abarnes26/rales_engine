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

    it "can find a single invoice via status" do
      invoice = create(:invoice, status: "shipped")

      get "/api/v1/invoices/find?status=#{invoice.status}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["status"]).to eq("shipped")
    end

    it "can find a single invoice via status regardless of case" do
      invoice = create(:invoice, status: "shipped")

      get "/api/v1/invoices/find?status=ShIpPeD"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["status"]).to eq("shipped")
    end

    it "can find a group of invoices via  a common status" do
      create_list(:invoice, 3, status: "shipped")
      create(:invoice)

      get "/api/v1/invoices/find_all?status=shipped"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Invoice.all.count).to eq(4)
      expect(result.count).to eq(3)
    end
  end
end
