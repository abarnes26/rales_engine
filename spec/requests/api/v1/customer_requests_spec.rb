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

    it "can find invoices associated with a particular customer" do
      customer_1 = create(:customer, first_name: "Sarah")
      customer_2 = create(:customer, first_name: "George")
      invoice_1 = create(:invoice, customer: customer_1)
      invoice_2 = create(:invoice, customer: customer_1)
      invoice_3 = create(:invoice, customer: customer_2)
      invoice_4 = create(:invoice, customer: customer_2)

      get "/api/v1/customers/#{customer_1.id}/invoices"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Invoice.all.count).to eq(4)
      expect(result.count).to eq(2)
      expect(result.first).to have_key("status")
    end

    it "can find transactions associated with a particular customer" do
      customer_1 = create(:customer, first_name: "Sarah")
      customer_2 = create(:customer, first_name: "George")
      invoice_1 = create(:invoice, customer: customer_1)
      invoice_2 = create(:invoice, customer: customer_1)
      invoice_3 = create(:invoice, customer: customer_2)
      invoice_4 = create(:invoice, customer: customer_2)
      transaction_1 = create(:transaction, invoice: invoice_1)
      transaction_2 = create(:transaction, invoice: invoice_2)
      transaction_3 = create(:transaction, invoice: invoice_2)
      transaction_4 = create(:transaction, invoice: invoice_3)
      transaction_5 = create(:transaction, invoice: invoice_4)
      transaction_6 = create(:transaction, invoice: invoice_4)

      get "/api/v1/customers/#{customer_1.id}/transactions"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Transaction.all.count).to eq(6)
      expect(result.count).to eq(3)
    end

  end
end
