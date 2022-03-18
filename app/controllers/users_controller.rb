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
             jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], "d52ef6ba1c804a5cfcbb00c3ad17103339209e8d64f46e4d98e173b0c2b4c3ace718dd7a31e43c6fa239592d29d10c7b5fdcf1f354eead1709285638e324d85c").first
            #jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], "b40fd77db45d6a45348d0c0de0f6ab8ebf16aafe3207d952fbad14e71ed672e1d50a6a6c58ce8de5d04392b17dc1a9251850e602b0cccfb176257f904df8b1bf").first
            user_id = jwt_payload['sub']
            user = User.find(user_id.to_s)
        end
end
