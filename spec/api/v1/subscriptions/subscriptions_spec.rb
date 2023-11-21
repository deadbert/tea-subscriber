require 'rails_helper'

RSpec.describe "Subscription endpoints" do
  describe "create subscription endpoint" do
    it "creates a new subscription for a customer" do
      bob = Customer.create(first_name: "bob", last_name: "belcher", email: "bob@bobsburgers.com", address: "1234 place st")
      the_green = Tea.create(
        title: "Tazo greent tips",
        description: "A light refreshing green tea for everyday refreshment",
        temperature: 175.5,
        brew_time: 3.45
      )

      data = {
        title: "The green to go",
        price: 15.50,
        status: 1,
        frequency: 1,
        customer_id: bob.id, 
        tea_id: the_green.id
      }

      post "/api/v1/subscriptions", params: data, as: :json

      expect(response).to be_successful

      new_sub = Subscription.last

      expect(new_sub.title).to eq("The green to go")
      expect(new_sub.price).to eq(15.50)
      expect(new_sub.status).to eq(1)
      expect(new_sub.frequency).to eq(1)
      expect(new_sub.customer_id).to eq(bob.id)
      expect(new_sub.tea_id).to eq(the_green.id)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key :data
      expect(result[:data]).to have_key :id
      expect(result[:data]).to have_key :type
      expect(result[:data][:type]).to eq("subscription")
      expect(result[:data]).to have_key :attributes
    end

    it "returns a 409 status and error message when invalid Subscription info is passed in the request" do

      data = {
        title: "The green to go",
        price: 15.50,
        status: 1,
        frequency: 1
      }

      post "/api/v1/subscriptions", params: data, as: :json

      expect(response.status).to eq(409)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key :error
      expect(result[:error]).to eq("Customer must exist,Tea must exist")
    end
  end
end