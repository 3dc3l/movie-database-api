require 'rails_helper'

RSpec.describe CastsController, type: :request do
  let(:cast) { create(:cast) }
  let(:create_url) { '/api/casts' }
  let(:updated_url) { '/api/casts/53' }
  let(:params) do 
      {
        first_name: cast.first_name,
        middle_name: cast.middle_name,
        last_name: cast.last_name,
        stage_name: cast.stage_name,
        stage_name: cast.stage_name,
        image: fixture_file_upload(Rails.root.join('spec', 'support', 'test_image.png'), 'image/png')
      }
  end

  describe "GET /index" do
    it "returns http success" do
      get casts_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    before do
      post create_url, params: params
    end

    it 'returns created' do
      expect(response).to have_http_status(:created)
    end
  end 

  describe "#update" do
    before do
      put updated_url, params: params
    end
    it "update a successful cast" do
      expect(response).to have_http_status(200)
    end
  end 

  describe 'DELETE /casts/:id' do    
    it 'deletes a cast' do 
      cast.save

      delete "/api/casts/#{cast.id}"
      expect(response).to have_http_status(200)
    end
  end 
end
