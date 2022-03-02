class FavoritesController < ApplicationController
    

    def add_remove_favorite
        user_id = params[:user_id]
        movie_id = params[:movie_id]

        favorite = Favorite.where(user_id: user_id, movie_id: movie_id).first

        if favorite
            remove_favorite(favorite)
        else
            add_favorite()
        end
    end

    def favorites
        user = get_user_from_token
        favorite_movies = user.movies.all.distinct

        render json: favorite_movies, include: ['image', 'genres']
    end

    private
        def favorite_params
            params.permit(:user_id, :movie_id)
        end

        def remove_favorite(favorite)
            favorite.destroy
     
            render json: favorite
        end

        def add_favorite()
            favorite = Favorite.new(favorite_params)
    
            if favorite.save
                render json: favorite, status: :created
            else
                render json: {
                    status: 'ERROR',
                    message: 'Data not saved',
                    data: favorite.errors
                }, status: :unprocessable_entity
            end
        end

        def get_user_from_token
            jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], ENV['DEVISE_JWT_SECRET_KEY']).first
            user_id = jwt_payload['sub']
            user = User.find(user_id.to_s)
        end
end
