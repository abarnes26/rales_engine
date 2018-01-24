require 'rails_helper'

describe "Invoice Items API" do
  context "HTTP GET" do
    it "sends a list of invoice_items" do
      create_list(:invoice_item, 3)

      get '/api/v1/invoice_items'

      expect(response).to be_success

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(3)
    end

    it "sends a single invoice_item" do
      id = create(:invoice_item).id

      get "/api/v1/invoice_items/#{id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item["id"]).to eq(id)
    end

    it "can find a single invoice_item via quantity" do
      invoice_item = create(:invoice_item, quantity: 9)

      get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["quantity"]).to eq(9)
      expect(result).to have_key("unit_price")
    end

    it "can find a single invoice_item based on created_at time" do
      create_list(:invoice_item, 3, quantity: 5)
      invoice_item = create(:invoice_item, quantity: 88, created_at: "2012-03-27 14:54:09 UTC")

      get "/api/v1/invoice_items/find?created_at=#{invoice_item.created_at}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["quantity"]).to eq(88)
      expect(result).to have_key("unit_price")
    end

    it "can find a single invoice_item based on updated_at time" do
      create_list(:invoice_item, 3, quantity: 5)
      invoice_item = create(:invoice_item, quantity: 88, updated_at: "2012-03-27 14:54:10 UTC")

      get "/api/v1/invoice_items/find?updated_at=#{invoice_item.updated_at}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["quantity"]).to eq(88)
      expect(result).to have_key("unit_price")
    end

    it "can find a single invoice_item via unit price" do
      invoice_item = create(:invoice_item, unit_price: 1099)

      get "/api/v1/invoice_items/find?unit_price=#{invoice_item.unit_price}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["unit_price"]).to eq(1099)
      expect(result).to have_key("quantity")
    end

    it "can find a single invoice_item at random" do
      create_list(:invoice_item, 10)

      get "/api/v1/invoice_items/random"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(InvoiceItem.all.count).to eq(10)
      expect(result).to have_key("quantity")
      expect(result).to have_key("unit_price")
    end

    it "can find a group of invoice items with a common quantity" do
      create_list(:invoice_item, 3, quantity: 11)
      create(:invoice_item, quantity: 7)

      get "/api/v1/invoice_items/find_all?quantity=11"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(InvoiceItem.all.count).to eq(4)
      expect(result.count).to eq(3)
    end

    it "can return associated item" do
      item_1 = create(:item, name: "Thing1")
      item_2 = create(:item, name: "Thing2")
      invoice_item = create(:invoice_item, item: item_2)

      get "/api/v1/invoice_items/#{invoice_item.id}/item"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Item.all.count).to eq(2)
      expect(result["name"]).to eq("Thing2")
    end

    it "can return associated item" do
      invoice_1 = create(:invoice, status: "Received")
      invoice_2 = create(:invoice, status: "Approved!")
      invoice_item = create(:invoice_item, invoice: invoice_2)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Invoice.all.count).to eq(2)
      expect(result["status"]).to eq("Approved!")
    end
  end
end
