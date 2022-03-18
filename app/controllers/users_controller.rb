class UsersController < ApplicationController 
    # before_action :authenticate_user!, only: [:show]

    def index
        users = User.where(is_admin: 0 ).order('created_at DESC')

        render :json => users.to_json
    end

    def show
        user = get_user_from_token
        favorite_movies = user.movies.all.distinct
        
        render json: {
            message: "If you see this, you're in!",
            user: user
        }
    end

    def destroy
        user = User.find_by_id(params[:id])
        user.destroy
        
        render json: user.to_json
    end

    private
        def get_user_from_token
            jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], ENV['DEVISE_JWT_SECRET_KEY']).first
            user_id = jwt_payload['sub']
            user = User.find(user_id.to_s)
        end
end