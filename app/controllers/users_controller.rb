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
            jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], '3d7dba432fa780813d8dcc03be4504c87f6438da4093cbef98052a8c0f1dd4e986fd8cc39737f609ca6b706d5f725b7a88acea247072526b340a388d0de2e828').first
            user_id = jwt_payload['sub']
            user = User.find(user_id.to_s)
        end
end
