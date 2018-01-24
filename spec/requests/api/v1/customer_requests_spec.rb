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

    it "can find a single customer via first_name" do
      customer = create(:customer, first_name: "Joey")

      get "/api/v1/customers/find?first_name=#{customer.first_name}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["first_name"]).to eq("Joey")
      expect(result).to have_key("last_name")
    end

    it "can find a single customer via first_name regardless of case" do
      customer = create(:customer, first_name: "Joey")

      get "/api/v1/customers/find?first_name=JoEy"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["first_name"]).to eq("Joey")
      expect(result).to have_key("last_name")
    end

    it "can find a single customer via last_name" do
      customer = create(:customer, last_name: "Hamilton")

      get "/api/v1/customers/find?last_name=#{customer.last_name}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["last_name"]).to eq("Hamilton")
      expect(result).to have_key("first_name")
    end

    it "can find a single customer based on created_at time" do
      create_list(:customer, 3)
      customer = create(:customer, first_name: "Jones", created_at: "2012-03-27 14:54:09 UTC")

      get "/api/v1/customers/find?created_at=#{customer.created_at}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["first_name"]).to eq("Jones")
      expect(result).to have_key("last_name")
    end

    it "can find a single customer based on updated_at time" do
      create_list(:customer, 3)
      customer = create(:customer, first_name: "Jones", updated_at: "2012-03-27 14:54:10 UTC")

      get "/api/v1/customers/find?updated_at=#{customer.updated_at}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["first_name"]).to eq("Jones")
      expect(result).to have_key("last_name")
    end

    it "can find a single customer via last_name regardless of case" do
      customer = create(:customer, last_name: "Hamilton")

      get "/api/v1/customers/find?last_name=hAmIlToN"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["last_name"]).to eq("Hamilton")
      expect(result).to have_key("first_name")
    end

    it "can find a single customer at random" do
      create_list(:customer, 10)

      get "/api/v1/customers/random"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Customer.all.count).to eq(10)
      expect(result).to have_key("first_name")
      expect(result).to have_key("last_name")
    end

    it "can find a group of customers with a common first name" do
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
