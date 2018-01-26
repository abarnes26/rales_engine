require 'rails_helper'

describe "Transactions API" do
  context "HTTP GET" do
    it "sends a list of transactions" do
      create_list(:transaction, 3)

      get '/api/v1/transactions'

      expect(response).to be_success

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(3)
    end

    it "sends a single transaction" do
      id = create(:transaction).id

      get "/api/v1/transactions/#{id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["id"]).to eq(id)
    end

    it "can find a single transaction via credit_card_number" do
      create(:transaction, credit_card_number: "111111111")
      transaction = create(:transaction, credit_card_number: "1234123412341234")

      get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Transaction.all.count).to eq(2)
      expect(result["credit_card_number"]).to eq("1234123412341234")
    end

    it "can find a single transaction via result" do
      create(:transaction, result: "failure")
      transaction = create(:transaction, result: "success", credit_card_number: "1112111211121112")

      get "/api/v1/transactions/find?result=#{transaction.result}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["result"]).to eq("success")
      expect(result["credit_card_number"]).to eq("1112111211121112")
    end

    it "can find a single transaction based on created_at time" do
      create_list(:transaction, 3, result: "failure")
      transaction = create(:transaction, result: "success", created_at: "2012-03-21 14:54:09 UTC")

      get "/api/v1/transactions/find?created_at=#{transaction.created_at}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["result"]).to eq("success")
    end

    it "can find a single transaction based on updated_at time" do
      create_list(:transaction, 3, result: "failure")
      transaction = create(:transaction, result: "success", updated_at: "2012-03-27 14:54:10 UTC")

      get "/api/v1/transactions/find?updated_at=#{transaction.updated_at}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["result"]).to eq("success")
    end

    it "can find a single transaction at random" do
      create_list(:transaction, 10)

      get "/api/v1/transactions/random"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Transaction.all.count).to eq(10)
      expect(result).to have_key("credit_card_number")
      expect(result).to have_key("result")
    end

    it "can find a group of transactions via result" do
      create_list(:transaction, 3, result: "success")
      create(:transaction, result: "failure")

      get "/api/v1/transactions/find_all?result=success"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Transaction.all.count).to eq(4)
      expect(result.count).to eq(3)
    end

    it "can find associated invoice" do
      invoice_1 = create(:invoice, status: "completed")
      transaction = create(:transaction, invoice: invoice_1)

      get "/api/v1/transactions/#{transaction.id}/invoice"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["status"]).to eq(invoice_1.status)
    end

  end
end
