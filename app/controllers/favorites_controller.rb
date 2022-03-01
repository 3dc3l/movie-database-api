class FavoritesController < ApplicationController
    def create
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

    def show_favorite 
       
    end

    def destroy
        favorite = Favorite.where(movie_id: params[:id]).first()
        favorite.destroy
 
        render json: favorite
    end

    private
        def favorite_params
            params.permit(:user_id, :movie_id)
        end
end
