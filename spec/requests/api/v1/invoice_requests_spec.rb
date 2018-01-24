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

    it "can find a single invoice based on created_at time" do
      create_list(:invoice, 3, status: "not the one you're looking for")
      invoice = create(:invoice, status: "This is the one", created_at: "2012-03-27 14:54:09 UTC")

      get "/api/v1/invoices/find?created_at=#{invoice.created_at}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["status"]).to eq("This is the one")
    end

    it "can find a single invoice based on updated_at time" do
      create_list(:invoice, 3, status: "not the one you're looking for")
      invoice = create(:invoice, status: "This is the one", updated_at: "2012-03-27 14:54:10 UTC")

      get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["status"]).to eq("This is the one")
    end

    it "can find a single invoice at random" do
      create_list(:invoice, 10)

      get "/api/v1/invoices/random"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Invoice.all.count).to eq(10)
      expect(result).to have_key("status")
    end

    it "can find a group of invoices via a common status" do
      create_list(:invoice, 3, status: "shipped")
      create(:invoice)

      get "/api/v1/invoices/find_all?status=shipped"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Invoice.all.count).to eq(4)
      expect(result.count).to eq(3)
    end

    it "can find associated transactions" do
      invoice = create(:invoice)
      transaction_1 = create(:transaction, invoice: invoice)
      transaction_2 = create(:transaction, invoice: invoice)
      transaction_3 = create(:transaction)

      get "/api/v1/invoices/#{invoice.id}/transactions"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Transaction.all.count).to eq(3)
      expect(result.count).to eq(2)
      expect(result.first).to have_key("result")
      expect(result.first).to have_key("credit_card_number")
    end

    it "can find associated invoice_item" do
      invoice = create(:invoice)
      invoice_item_1 = create(:invoice_item, invoice: invoice)
      invoice_item_2 = create(:invoice_item, invoice: invoice)
      invoice_item_3 = create(:invoice_item)

      get "/api/v1/invoices/#{invoice.id}/invoice_items"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(InvoiceItem.all.count).to eq(3)
      expect(result.count).to eq(2)
      expect(result.first).to have_key("quantity")
      expect(result.first).to have_key("unit_price")
    end

    it "can find associated items" do
      invoice = create(:invoice)
      item_1 = create(:item)
      item_2 = create(:item)
      item_3 = create(:item)
      invoice_item_1 = create(:invoice_item, invoice: invoice, item: item_1)
      invoice_item_2 = create(:invoice_item, invoice: invoice, item: item_2)

      get "/api/v1/invoices/#{invoice.id}/items"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Item.all.count).to eq(3)
      expect(result.count).to eq(2)
      expect(result.first).to have_key("name")
      expect(result.first).to have_key("description")
      expect(result.first).to have_key("unit_price")
    end

    it "can find associated customer" do
      customer_1 = create(:customer)
      customer_2 = create(:customer, first_name: "Haley")
      invoice = create(:invoice, customer: customer_2)

      get "/api/v1/invoices/#{invoice.id}/customer"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Customer.all.count).to eq(2)
      expect(result["first_name"]).to eq("Haley")
      expect(result).to have_key("first_name")
      expect(result).to have_key("last_name")
    end
  end
end
