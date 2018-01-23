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
  end
end
