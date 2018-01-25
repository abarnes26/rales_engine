require 'rails_helper'

describe "Items API" do
  context "HTTP GET" do
    it "sends a list of items" do
      create_list(:item, 3)

      get '/api/v1/items'

      expect(response).to be_success

      items = JSON.parse(response.body)

      expect(items.count).to eq(3)
    end

    it "sends a single item" do
      id = create(:item).id

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["id"]).to eq(id)
    end

    it "can find a single item via name" do
      item = create(:item, name: "Jones tails")

      get "/api/v1/items/find?name=#{item.name}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["name"]).to eq("Jones tails")
    end

    it "can find a single item via name regardless of case" do
      item = create(:item, name: "Jones Tails")

      get "/api/v1/items/find?name=jOnEs%20taILs"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["name"]).to eq("Jones Tails")
    end

    it "can find a single item via description" do
      item = create(:item, description: "That other thing you wanted")

      get "/api/v1/items/find?description=#{item.description}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["description"]).to eq("That other thing you wanted")
    end

    it "can find a single item via description regardless of case" do
      item = create(:item, description: "That other thing you wanted")

      get "/api/v1/items/find?description=THAT other THING you WANTED"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["description"]).to eq("That other thing you wanted")
    end

    it "can find a single item via unit price" do
      item = create(:item, unit_price: 333)

      get "/api/v1/items/find?unit_price=#{item.unit_price}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["unit_price"]).to eq(333)
    end

    it "can find a single item based on created_at time" do
      create_list(:item, 3, description: "not the one you're looking for")
      item = create(:item, description: "This is the one", created_at: "2012-03-27 14:54:09 UTC")

      get "/api/v1/items/find?created_at=#{item.created_at}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["description"]).to eq("This is the one")
    end

    it "can find a single item based on updated_at time" do
      create_list(:item, 3, description: "not the one you're looking for")
      item = create(:item, description: "This is the one", updated_at: "2012-03-27 14:54:10 UTC")

      get "/api/v1/items/find?updated_at=#{item.updated_at}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["description"]).to eq("This is the one")
    end

    it "can find a single item at random" do
      create_list(:item, 10)

      get "/api/v1/items/random"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Item.all.count).to eq(10)
      expect(result).to have_key("name")
      expect(result).to have_key("description")
      expect(result).to have_key("unit_price")
    end

    it "can find a group of items with a common unit price" do
      create_list(:item, 3, unit_price: 301)
      create(:item, unit_price: 70)

      get "/api/v1/items/find_all?unit_price=301"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Item.all.count).to eq(4)
      expect(result.count).to eq(3)
    end

    it "can find associated invoice_items" do
      item = create(:item)
      invoice_item_1 = create(:invoice_item, quantity: 5, item: item)
      invoice_item_2 = create(:invoice_item, quantity: 18, item: item)
      invoice_item_3 = create(:invoice_item)

      get "/api/v1/items/#{item.id}/invoice_items"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(InvoiceItem.all.count).to eq(3)
      expect(result.first["quantity"]).to eq(5)
    end

    it "can find associated merchants" do
      merchant_1 = create(:merchant, name: "Daniels")
      merchant_2 = create(:merchant)
      item = create(:item, merchant: merchant_1)

      get "/api/v1/items/#{item.id}/merchant"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Merchant.all.count).to eq(2)
      expect(result["name"]).to eq("Daniels")
    end

    it "can find a list of x number of items with the highest revenue" do
      item_1 = create(:item)
      item_2 = create(:item)
      item_3 = create(:item, name: "Most Popular")
      item_4 = create(:item, name: "Second Most Popular")
      item_5 = create(:item)
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)
      invoice_3 = create(:invoice)
      invoice_4 = create(:invoice)
      invoice_5 = create(:invoice)
      invoice_6 = create(:invoice)
      invoice_7 = create(:invoice)
      invoice_8 = create(:invoice)
      invoice_9 = create(:invoice)
      transaction_1 = create(:transaction, invoice: invoice_1)
      transaction_2 = create(:transaction, invoice: invoice_2)
      transaction_3 = create(:transaction, invoice: invoice_3)
      transaction_4 = create(:transaction, invoice: invoice_4)
      transaction_5 = create(:transaction, invoice: invoice_5)
      transaction_6 = create(:transaction, invoice: invoice_6)
      transaction_7 = create(:transaction, invoice: invoice_7)
      transaction_8 = create(:transaction, invoice: invoice_8)
      transaction_9 = create(:transaction, invoice: invoice_9)
      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1)
      invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2)
      invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_3)
      invoice_item_4 = create(:invoice_item, item: item_3, invoice: invoice_4)
      invoice_item_5 = create(:invoice_item, item: item_3, invoice: invoice_5)
      invoice_item_6 = create(:invoice_item, item: item_3, invoice: invoice_6)
      invoice_item_7 = create(:invoice_item, item: item_4, invoice: invoice_7)
      invoice_item_8 = create(:invoice_item, item: item_4, invoice: invoice_8)
      invoice_item_8 = create(:invoice_item, item: item_4, invoice: invoice_9)

      get "/api/v1/items/most_revenue?quantity=2"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result.count).to eq(2)
      expect(result.first["name"]).to eq("Most Popular")
      expect(result.last["name"]).to eq("Second Most Popular")

    end
  end
end
