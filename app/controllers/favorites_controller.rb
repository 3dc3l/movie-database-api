class FavoritesController < ApplicationController
   #before_action :authenticate_user!

    def add_remove_favorite
        favorite = FavoritesFacade.new(favorite_params)
        render favorite.add_remove_favorite
    end

    def favorites
        user = get_user_from_token
        favorite_movies = user.movies.all.distinct

        options = {
            :include => :genres,
            :methods => :get_image_url
        }

        render :json => favorite_movies.to_json(options)
    end

    private
        def favorite_params
            params.permit(:user_id, :movie_id)
        end

        def get_user_from_token
            #server
            jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], "d52ef6ba1c804a5cfcbb00c3ad17103339209e8d64f46e4d98e173b0c2b4c3ace718dd7a31e43c6fa239592d29d10c7b5fdcf1f354eead1709285638e324d85c").first
            #local
            # jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], "b40fd77db45d6a45348d0c0de0f6ab8ebf16aafe3207d952fbad14e71ed672e1d50a6a6c58ce8de5d04392b17dc1a9251850e602b0cccfb176257f904df8b1bf").first
            user_id = jwt_payload['sub']
            user = User.find(user_id.to_s)
        end
end
