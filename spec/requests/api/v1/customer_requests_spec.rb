require 'rails_helper'

describe "Customers API" do
  context "HTTP GET" do
    it "sends a list of customers" do
      create_list(:customer, 3)

      get '/api/v1/customers'

      expect(response).to be_success

      customers = JSON.parse(response.body)

      expect(customers.count).to eq(3)
    end

    it "sends a single customer" do
      id = create(:customer).id

      get "/api/v1/customers/#{id}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["id"]).to eq(id)
    end

    it "can find a single customer via params" do
      customer = create(:customer, first_name: "Joey")

      get "/api/v1/customers/find?first_name=#{customer.first_name}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["first_name"]).to eq("Joey")
      expect(result).to have_key("last_name")
    end
  end
end
