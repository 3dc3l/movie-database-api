require 'rails_helper'

RSpec.describe MoviesController, type: :request do
	let(:movie) { create(:movie) }
	let(:create_url) { "/api/movies" }
	let(:updated_url) { "/api/movies/#{movie.id}" }
	let(:params) do 
		{ 
			title: "title", 
			slug: "slug", 
			image: fixture_file_upload(Rails.root.join('spec', 'support', 'test_image.png'), 'image/png') 
		}
	end

	describe "GET /index" do
		it "returns http success" do
			get movies_path
			expect(response).to have_http_status(:success)
		end
	end

	describe "#create" do
		it 'returns 422, if params properties not complete' do
			post create_url, params: params
			expect(response).to have_http_status(:unprocessable_entity)
		end

		it 'create movie, if params complete' do 
			params.merge!("release_year" => 2019)
			post create_url, params: params

			expect(response).to have_http_status(:success)
		end
	end 

	describe "#update" do
		it 'update movie, if params complete' do 
			put updated_url, params: params

			expect(response).to have_http_status(:success)
		end
	end 

	describe 'DELETE /movies/:id' do    
		it 'deletes a movie' do 
			movie.save

			delete "/api/movies/#{movie.id}"
			expect(response).to have_http_status(200)
		end
	end 

end