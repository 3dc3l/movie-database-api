class GenresController < ApplicationController
    def index
        genres = Genre.order('created_at DESC');
        render json: genres
    end

    def show
        genre = Genre.find_by_id(params[:id])
        render json: genre
    end

    def create
        genre = Genre.new(genre_params)

        if genre.save
            render json: genre
        else
            render json: {
                status: 'ERROR',
                message: 'genre not saved',
                data: genre.errors
            }, status: :unprocessable_entity
        end
    end

    def update
        genre = Genre.find_by_id(params[:id])
    
        if genre.update(genre_params)
            render json: genre
        else
            render json: {
                status: 'ERROR',
                message: 'genre not saved',
                data: genre.errors
            }, status: :unprocessable_entity
        end
    end

    def destroy
        genre = Genre.find_by_id(params[:id])
        genre.destroy

        render json: genre
    end

    private
        def genre_params
            params.permit(:title)
        end
end
