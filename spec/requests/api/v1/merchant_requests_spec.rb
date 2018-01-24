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
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(id)
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
      merchant = create(:merchant, name: "I'm the one", created_at: "2012-03-27 14:54:09 UTC")

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
  end
end
