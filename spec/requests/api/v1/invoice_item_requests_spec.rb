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

    xit "can find a single customer via last_name" do
      customer = create(:customer, last_name: "Hamilton")

      get "/api/v1/customers/find?last_name=#{customer.last_name}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["last_name"]).to eq("Hamilton")
      expect(result).to have_key("first_name")
    end

    xit "can find a group of customers with a common first name" do
      create_list(:customer, 3, first_name: "Hank")
      create(:customer, first_name: "Sarah")

      get "/api/v1/customers/find_all?first_name=Hank"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Customer.all.count).to eq(4)
      expect(result.count).to eq(3)
    end
  end
end
