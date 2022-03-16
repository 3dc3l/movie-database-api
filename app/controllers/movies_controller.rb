class MoviesController < ApplicationController
    # before_action :authenticate_admin!, only: [:create, :update, :destroy]

    def index
        movies = MoviesFacade.new

        render movies.all_movies
    end

    def show
        movie = MoviesFacade.new(params)

        render movie.show
    end
    
    def create
       movies = MoviesFacade.new(params, movie_params)

       render movies.create
    end
    
    def update
        movies = MoviesFacade.new(params, movie_params)

       render movies.update
    end
    
    def destroy
        movie = Movie.find_by_id(params[:id])
        movie.destroy
        
        render json: movie.to_json
    end
    
    private
        def movie_params
            params.permit(:id, :title, :release_year, :thumbnail_url, :slug, :image, :cast_id, :genre_id)
        end
end
