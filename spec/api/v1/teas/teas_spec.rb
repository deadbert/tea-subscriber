require 'rails_helper'

RSpec.describe "Teas endpoints" do
  before(:each) do
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
  end
  describe "get teas endpoint" do
    it "returns a list of teas from the DB" do

      get "/api/v1/teas"

      expect(response).to be_successful
    end
  end
end