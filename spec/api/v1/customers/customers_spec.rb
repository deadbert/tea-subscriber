require 'rails_helper'

RSpec.describe "Customers endpoints" do
  describe "POST customers endpoint" do
    it "creates a new customer" do

      data = { 
        first_name: "Tina", 
        last_name: "belcher", 
        email: "tina@bobsburgers.com", 
        address: "1234 place st", 
        password: "1234"
      }

      post "/api/v1/customers", params: data, as: :json

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key :data
      expect(result[:data]).to have_key :id
      expect(result[:data]).to have_key :type
      expect(result[:data]).to have_key :attributes
      expect(result[:data][:type]).to eq("customer")
    end
  end
  
  describe "GET request to Customers endpoint" do
    it "returns a list of current customers in the DB" do
      gene = Customer.create(first_name: "Gene", last_name: "Belcher", email: "gene@bobsburgers.com", address: "1234 place street", password: "1234")

      get "/api/v1/customers"

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key :data
      expect(result[:data]). to be_an Array

      expect(result[:data].first).to have_key :id
      expect(result[:data].first).to have_key :type
      expect(result[:data].first).to have_key :attributes

      expect(result[:data].first[:type]).to eq("customer")
    end
  end
end