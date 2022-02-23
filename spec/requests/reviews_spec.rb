require 'rails_helper'

RSpec.describe ReviewsController, type: :request do
  let(:review) { create(:review) }
  let(:create_url) { '/api/reviews' }
  let(:updated_url) { "/api/reviews/#{ review.id }" }
  let(:params) do 
      {
        content: review.content,
        rating: review.rating
      }
  end

  describe "GET /index" do
    it "returns http success" do
      get reviews_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    before do
      post create_url, params: params
    end

    it "if parameters are valid , will return created" do
      expect(response).to have_http_status(:created)
    end
  end 

  describe "should show products" do 
      get "/api/reviews/#{ review.id }"

      expect(response).to have_http_status(:success)
  end

  describe "#update" do
    before do
      put updated_url, params: params
    end
    it "update a successful cast" do
      expect(response).to have_http_status(:success)
    end
  end 

  describe 'DELETE /reviews/:id' do    
    it 'deletes a movie' do 

      delete "/api/reviews/#{review.id}"
      expect(response).to have_http_status(:success)
    end
  end 
end
