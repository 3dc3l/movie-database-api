class FavoritesController < ApplicationController
    before_action :authenticate_user!

    def add_remove_favorite
        favorite = FavoritesFacade.new
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
end
