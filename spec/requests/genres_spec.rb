require 'rails_helper'

RSpec.describe GenresController, type: :request do
  let(:genre) { create(:genre) }
  let(:create_url) { '/api/genres' }
  let(:updated_url) { "/api/genres/#{ genre.id }" }
  let(:params) do 
      {
        title: genre.title
      }
  end

  describe "GET /index" do
    it "returns http success" do
      get genres_path
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
      expect(response).to have_http_status(:success)
    end
  end 

  describe 'DELETE /genres/:id' do    
    it 'deletes a movie' do 

      delete "/api/genres/#{genre.id}"
      expect(response).to have_http_status(:success)
    end
  end 
end
