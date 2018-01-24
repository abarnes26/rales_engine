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

    it "can find a group of transactions via result" do
      create_list(:transaction, 3, result: "success")
      create(:transaction, result: "failure")

      get "/api/v1/transactions/find_all?result=success"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Transaction.all.count).to eq(4)
      expect(result.count).to eq(3)
    end

  end
end
