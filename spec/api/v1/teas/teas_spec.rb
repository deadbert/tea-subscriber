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

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key :data
      expect(result[:data]).to be_an Array
      expect(result[:data].first).to have_key :id
      expect(result[:data].first).to have_key :type
      expect(result[:data].first).to have_key :attributes
      expect(result[:data].first[:type]).to eq("tea")
      expect(result[:data].first[:attributes]).to have_key :title
      expect(result[:data].first[:attributes]).to have_key :description
      expect(result[:data].first[:attributes]).to have_key :temperature
      expect(result[:data].first[:attributes]).to have_key :brew_time
    end
  end

  describe "POST teas endpoint" do
    it "creates a new tea resource in the DB" do

      data = {
        title: "Lapsang Su Chong",
        description: "A smokey tea from China",
        temperature: 175.5,
        brew_time: 3.45
      }

      post "/api/v1/teas", params: data, as: :json

      expect(response).to be_successful
    end
  end
end