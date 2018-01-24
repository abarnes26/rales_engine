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

    it "can find a group of items with a common unit price" do
      create_list(:item, 3, unit_price: 301)
      create(:item, unit_price: 70)

      get "/api/v1/items/find_all?unit_price=301"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Item.all.count).to eq(4)
      expect(result.count).to eq(3)
    end
  end
end
