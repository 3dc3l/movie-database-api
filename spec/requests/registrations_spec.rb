require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :request do
	describe "POST /sign_up" do 
		it "should create a new instance of a user given valid attributes" do
  			expect {
  				post '/users', params: {
  					"user": { "email": "test@gmail.com", "password": "password", "password_confirmation": "password", "is_admin": 1 } 
  				}
  			}.to change {User.count}.from(0).to(1)
		end
	end
end