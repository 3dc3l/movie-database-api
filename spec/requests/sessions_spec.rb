require 'rails_helper'

RSpec.describe Users::SessionsController, type: :request do
	let(:user) { create(:user) }
	let(:url) { '/users/sign_in' }
	let(:params) do
		{
			user: {
				email: user.email,
				password: user.password
			}
		}
	end

	describe 'check if signed in' do
		before do
			post url, params: params
		end

		it 'returns 200' do
	    	expect(response).to have_http_status(200)
	    end

	    it 'returns JTW token in authorization header' do
	      expect(response.headers['Authorization']).to be_present
	    end
	end
end