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
            jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], "8b07088fad6d639b701d2babf297c9429c3d210c18795424b505e5378697c3d11b11e18a09a02acfdd88ff3c1a9e27fb121462703da0c93c47b208326a101eb5").first
            user_id = jwt_payload['sub']
            user = User.find(user_id.to_s)
        end
end
