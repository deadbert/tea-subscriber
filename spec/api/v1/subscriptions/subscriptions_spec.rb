require 'rails_helper'

RSpec.describe "Subscription endpoints" do
  describe "create subscription endpoint" do
    it "creates a new subscrition for a customer" do
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

      post "/api/v1/subscriptions", params: data

      expect(response).to be_successful

      
    end
  end
end