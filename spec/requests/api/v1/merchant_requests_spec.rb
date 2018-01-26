require 'rails_helper'

describe "Merchants API" do
  context "HTTP GET" do
    it "sends a list of merchants" do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_success

      merchants = JSON.parse(response.body)

      expect(merchants.count).to eq(3)
    end

    it "sends a single merchant" do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["name"]).to eq(merchant.name)
    end

    it "can find a single merchant via name" do
      merchant = create(:merchant, name: "Hagar Tulip")

      get "/api/v1/merchants/find?name=#{merchant.name}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["name"]).to eq("Hagar Tulip")
    end

    it "can find a single merchant via name regardless of case" do
      merchant = create(:merchant, name: "Hagar Tulip")

      get "/api/v1/merchants/find?name=HaGAr%20TULip"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["name"]).to eq("Hagar Tulip")
    end

    it "can find a single merchant based on created_at time" do
      create_list(:merchant, 3, name: "not it!")
      merchant = create(:merchant, name: "I'm the one", created_at: "2012-03-21 14:54:09 UTC")

      get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["name"]).to eq("I'm the one")
    end

    it "can find a single merchant based on updated_at time" do
      create_list(:merchant, 3, name: "not it!")
      merchant = create(:merchant, name: "I'm the one", updated_at: "2012-03-27 14:54:10 UTC")

      get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["name"]).to eq("I'm the one")
    end

    it "can find a single merchant at random" do
      create_list(:merchant, 10)

      get "/api/v1/merchants/random"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Merchant.all.count).to eq(10)
      expect(result).to have_key("name")
    end

    it "can find a group of merchants via name" do
      create_list(:merchant, 3, name: "John Johnson")
      create(:merchant)

      get "/api/v1/merchants/find_all?name=John%20Johnson"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Merchant.all.count).to eq(4)
      expect(result.count).to eq(3)
    end

    it "can find associated invoices" do
      merchant = create(:merchant)
      invoice_1 = create(:invoice, status: "completed", merchant: merchant)
      invoice_2 = create(:invoice, merchant: merchant)
      invoice_3 = create(:invoice)

      get "/api/v1/merchants/#{merchant.id}/invoices"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Invoice.all.count).to eq(3)
      expect(result.first["status"]).to eq(invoice_1.status)
    end

    it "can find associated items" do
      merchant = create(:merchant)
      item_1 = create(:item, name: "House Plant", merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      item_3 = create(:item)

      get "/api/v1/merchants/#{merchant.id}/items"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Item.all.count).to eq(3)
      expect(result.first["name"]).to eq(item_1.name)
    end

    it "can find the top merchants by revenue" do
      merchant_1 = create(:merchant, name: "Johnson")
      merchant_2 = create(:merchant, name: "Calley")
      merchant_3 = create(:merchant)
      merchant_4 = create(:merchant)
      merchant_5 = create(:merchant)
      invoice_1 = create(:invoice, merchant: merchant_1)
      invoice_2 = create(:invoice, merchant: merchant_1)
      invoice_3 = create(:invoice, merchant: merchant_1)
      invoice_4 = create(:invoice, merchant: merchant_2)
      invoice_5 = create(:invoice, merchant: merchant_2)
      invoice_6 = create(:invoice, merchant: merchant_3)
      invoice_7 = create(:invoice, merchant: merchant_4)
      invoice_8 = create(:invoice, merchant: merchant_5)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2)
      invoice_item_3 = create(:invoice_item, invoice: invoice_3)
      invoice_item_4 = create(:invoice_item, invoice: invoice_4)
      invoice_item_5 = create(:invoice_item, invoice: invoice_5)
      invoice_item_6 = create(:invoice_item, invoice: invoice_6)
      invoice_item_7 = create(:invoice_item, invoice: invoice_7)
      invoice_item_8 = create(:invoice_item, invoice: invoice_8)
      transaction_1 = create(:transaction, invoice: invoice_1)
      transaction_2 = create(:transaction, invoice: invoice_2)
      transaction_3 = create(:transaction, invoice: invoice_3)
      transaction_4 = create(:transaction, invoice: invoice_4)
      transaction_5 = create(:transaction, invoice: invoice_5)
      transaction_6 = create(:transaction, invoice: invoice_6)
      transaction_7 = create(:transaction, invoice: invoice_7)
      transaction_8 = create(:transaction, invoice: invoice_8)

      get "/api/v1/merchants/most_revenue?quantity=2"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Merchant.count).to eq(13)
      expect(result.count).to eq(2)
      expect(result.first["name"]).to eq(merchant_1.name)
      expect(result.last["name"]).to eq(merchant_2.name)
    end

    it "can find the top merchants by items sold" do
      merchant_1 = create(:merchant, name: "Johnson")
      merchant_2 = create(:merchant, name: "Calley")
      merchant_3 = create(:merchant)
      merchant_4 = create(:merchant)
      merchant_5 = create(:merchant)
      item_1 = create(:item, merchant: merchant_1)
      item_2 = create(:item, merchant: merchant_2)
      item_3 = create(:item, merchant: merchant_3)
      item_4 = create(:item, merchant: merchant_4)
      item_5 = create(:item, merchant: merchant_5)
      invoice_1 = create(:invoice, merchant: merchant_1)
      invoice_2 = create(:invoice, merchant: merchant_1)
      invoice_3 = create(:invoice, merchant: merchant_1)
      invoice_4 = create(:invoice, merchant: merchant_2)
      invoice_5 = create(:invoice, merchant: merchant_2)
      invoice_6 = create(:invoice, merchant: merchant_3)
      invoice_7 = create(:invoice, merchant: merchant_4)
      invoice_8 = create(:invoice, merchant: merchant_5)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_1)
      invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_1)
      invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_2)
      invoice_item_5 = create(:invoice_item, invoice: invoice_5, item: item_2)
      invoice_item_6 = create(:invoice_item, invoice: invoice_6, item: item_3)
      invoice_item_7 = create(:invoice_item, invoice: invoice_7, item: item_4)
      invoice_item_8 = create(:invoice_item, invoice: invoice_8, item: item_5)
      transaction_1 = create(:transaction, invoice: invoice_1)
      transaction_2 = create(:transaction, invoice: invoice_2)
      transaction_3 = create(:transaction, invoice: invoice_3)
      transaction_4 = create(:transaction, invoice: invoice_4)
      transaction_5 = create(:transaction, invoice: invoice_5)
      transaction_6 = create(:transaction, invoice: invoice_6)
      transaction_7 = create(:transaction, invoice: invoice_7)
      transaction_8 = create(:transaction, invoice: invoice_8)

      get "/api/v1/merchants/most_items?quantity=2"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Merchant.count).to eq(5)
      expect(result.count).to eq(2)
      expect(result.first["name"]).to eq(merchant_1.name)
      expect(result.last["name"]).to eq(merchant_2.name)
    end

    it "can find the total revenue for a single merchant" do
      merchant_1 = create(:merchant)
      item_1 = create(:item, merchant: merchant_1)
      invoice_1 = create(:invoice, merchant: merchant_1)
      invoice_2 = create(:invoice, merchant: merchant_1)
      invoice_3 = create(:invoice, merchant: merchant_1)
      invoice_4 = create(:invoice, merchant: merchant_1)
      invoice_5 = create(:invoice, merchant: merchant_1)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_1)
      invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_1)
      invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_1)
      invoice_item_5 = create(:invoice_item, invoice: invoice_5, item: item_1)
      transaction_1 = create(:transaction, invoice: invoice_1)
      transaction_2 = create(:transaction, invoice: invoice_2)
      transaction_3 = create(:transaction, invoice: invoice_3)
      transaction_4 = create(:transaction, invoice: invoice_4)
      transaction_5 = create(:transaction, invoice: invoice_5, result: "failed")

      get "/api/v1/merchants/#{merchant_1.id}/revenue"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["total_revenue"]).to eq("2000.00")
    end

    it "can find the merchant's favorite customer" do
      merchant_1 = create(:merchant, name: "Sarah")
      customer_1 = create(:customer, first_name: "Jose")
      customer_2 = create(:customer, first_name: "Johnson")
      customer_3 = create(:customer, first_name: "Jessilee")
      invoice_1 = create(:invoice, customer: customer_1, merchant: merchant_1)
      invoice_2 = create(:invoice, customer: customer_2, merchant: merchant_1)
      invoice_3 = create(:invoice, customer: customer_2, merchant: merchant_1)
      invoice_4 = create(:invoice, customer: customer_2, merchant: merchant_1)
      invoice_5 = create(:invoice, customer: customer_2, merchant: merchant_1)
      invoice_6 = create(:invoice, customer: customer_3, merchant: merchant_1)
      invoice_7 = create(:invoice, customer: customer_3, merchant: merchant_1)
      transaction_1 = create(:transaction, invoice: invoice_1)
      transaction_2 = create(:transaction, invoice: invoice_2)
      transaction_3 = create(:transaction, invoice: invoice_3)
      transaction_4 = create(:transaction, invoice: invoice_4)
      transaction_5 = create(:transaction, invoice: invoice_5)
      transaction_6 = create(:transaction, invoice: invoice_6)
      transaction_6 = create(:transaction, invoice: invoice_7)

      get "/api/v1/merchants/#{merchant_1.id}/favorite_customer"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Customer.count).to eq(3)
      expect(result.count).to eq(1)
      expect(result.first["first_name"]).to eq("Johnson")
    end

    it "can find the total revenue for a given date" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      merchant_4 = create(:merchant)
      merchant_5 = create(:merchant)
      invoice_1 = create(:invoice, merchant: merchant_1)
      invoice_2 = create(:invoice, merchant: merchant_1)
      invoice_3 = create(:invoice, merchant: merchant_2)
      invoice_4 = create(:invoice, merchant: merchant_2)
      invoice_5 = create(:invoice, merchant: merchant_3)
      invoice_6 = create(:invoice, merchant: merchant_4)
      invoice_7 = create(:invoice, merchant: merchant_5)
      item_1 = create(:item, merchant: merchant_1)
      item_2 = create(:item, merchant: merchant_1)
      item_3 = create(:item, merchant: merchant_2)
      item_4 = create(:item, merchant: merchant_2)
      item_5 = create(:item, merchant: merchant_3)
      item_6 = create(:item, merchant: merchant_4)
      item_7 = create(:item, merchant: merchant_5)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2)
      invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_3)
      invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_4)
      invoice_item_5 = create(:invoice_item, invoice: invoice_5, item: item_5)
      invoice_item_6 = create(:invoice_item, invoice: invoice_6, item: item_6)
      invoice_item_7 = create(:invoice_item, invoice: invoice_7, item: item_7)
      transaction_1 = create(:transaction, invoice: invoice_1)
      transaction_2 = create(:transaction, invoice: invoice_2)
      transaction_3 = create(:transaction, invoice: invoice_3)
      transaction_4 = create(:transaction, invoice: invoice_4)
      transaction_5 = create(:transaction, invoice: invoice_5)
      transaction_6 = create(:transaction, invoice: invoice_6)
      transaction_7 = create(:transaction, invoice: invoice_7)

      get "/api/v1/merchants/revenue?date=#{invoice_1.created_at}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["total_revenue"]).to eq("3500.00")

    end

  end
end
