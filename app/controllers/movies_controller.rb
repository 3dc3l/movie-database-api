class MoviesController < ApplicationController

    def index
        movies = Movie.order('created_at DESC');
    
        render json: {
            status: 'SUCCESS',
            message: 'Loaded Movies',
            data:movies
        }, status: :ok
    end
    
    def show
        movie = Movie.find(params[:id])
    
        render json: {
            status: 'SUCCESS',
            message: 'Loaded movie',
            data: movie
        }, status: :ok
    end
    
    def create
        movie = Movie.new(movie_params)
        cast = Cast.find(params[:cast_id])

        movie.casts << cast

        if movie.save
            render json: {
                status: 'SUCCESS',
                message: 'Saved Movie',
                data: movie
            }, status: :ok
        else
            render json: {
                status: 'ERROR',
                message: 'Movie not saved',
                data: movie.errors
            }, status: :unprocessable_entity
        end
    end
    
    def update
        movie = Movie.find(params[:id])
    
        if movie.update(movie_params)
            render json: {
                status: 'SUCCESS',
                message: 'Updated movie',
                data: movie
            }, status: :ok
        else
            render json: {
                status: 'ERROR',
                message: 'Movie not updated',
                data: movie.errors
            }, status: :unprocessable_entity
        end
    end
    
    def destroy
        movie = Movie.find(params[:id])

        movie.destroy
        render json: {
            status: 'SUCCESS',
            message: 'Deleted movie',
        }, status: :ok
    end
    
    private
    
        def movie_params
            params.permit(:id, :title, :release_year, :thumbnail_url)
        end
end
