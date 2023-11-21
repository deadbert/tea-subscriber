require 'rails_helper'

RSpec.describe "Subscription endpoints" do
  before(:each) do
    @bob = Customer.create(first_name: "bob", last_name: "belcher", email: "bob@bobsburgers.com", address: "1234 place st")
    @tina = Customer.create(first_name: "Tina", last_name: "belcher", email: "tina@bobsburgers.com", address: "1234 place st")

    @the_green = Tea.create(
      title: "Tazo greent tips",
      description: "A light refreshing green tea for everyday refreshment",
      temperature: 175.5,
      brew_time: 3.45
    )
    
    @the_earl = Tea.create(
      title: "Tazo Earl Gray",
      description: "A classic english lunch tea",
      temperature: 180.5,
      brew_time: 4.10
    )

    Subscription.create(
      title: "go for green",
      price: 15.00,
      status: 1,
      frequency: 0,
      customer_id: @tina.id,
      tea_id: @the_green.id
    )

    Subscription.create(
      title: "Lunch all the time",
      price: 17.00,
      status: 0,
      frequency: 1,
      customer_id: @tina.id,
      tea_id: @the_green.id
    )

  end
  describe "create subscription endpoint" do
    it "creates a new subscription for a customer" do

      data = {
        title: "The green to go",
        price: 15.50,
        status: 1,
        frequency: 1,
        customer_id: @bob.id, 
        tea_id: @the_green.id
      }

      post "/api/v1/subscriptions", params: data, as: :json

      expect(response).to be_successful

      new_sub = Subscription.last

      expect(new_sub.title).to eq("The green to go")
      expect(new_sub.price).to eq(15.50)
      expect(new_sub.status).to eq("active")
      expect(new_sub.frequency).to eq("weekly")
      expect(new_sub.customer_id).to eq(@bob.id)
      expect(new_sub.tea_id).to eq(@the_green.id)

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

  describe "user Subscriptions index endpoint" do
    it "Shows all subscriptions for a user, active or cancelled" do

      get "/api/v1/subscriptions?customer_id=#{@tina.id}"

      expect(response).to be_successful
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key :data
      expect(result[:data]).to be_an Array
      expect(result[:data].first).to have_key :id
      expect(result[:data].first).to have_key :type
      expect(result[:data].first).to have_key :attributes
      expect(result[:data].first[:type]).to eq("subscription")
      expect(result[:data].second[:attributes][:status]).to eq("cancelled")
      expect(result[:data].first[:attributes][:status]).to eq("active")
    end

    it "returns error when customer_id is not valid" do

      get "/api/v1/subscriptions?customer_id=-1"

      expect(response).to_not be_successful
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key :error
      expect(result[:error]).to eq("Couldn't find Customer with 'id'=-1")
    end
  end
end