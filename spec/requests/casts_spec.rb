require 'rails_helper'

RSpec.describe "Casts", type: :request do
  before :each do
    @image = fixture_file_upload('support/test_image.png', 'image/png')
  end

  describe "GET /index" do
    it "returns http success" do
      get casts_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    it "creates a successful cast" do
      # @cast =  Cast.create()
      # @cast.should be_an_instance_of Cast
      post '/api/casts', params: {first_name: "xency", suffix: "d", middle_name: "calzo", last_name: 'estadola', stage_name: 'naruto', image: @image} 
      
      expect(response).to have_http_status(:created)
    end
  end 

  describe 'DELETE /casts/:id' do
    it 'deletes a cast' do 
      delete '/api/casts/25'

      expect(response).to have_http_status(200)
    end
  end 
end
