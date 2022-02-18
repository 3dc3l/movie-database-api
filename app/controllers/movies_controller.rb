class MoviesController < ApplicationController

    def index
        movies = Movie.order('created_at DESC');

        render json: movies
    end
    
    def show
        movie = Movie.find(params[:id])
        
        render json: movie
    end
    
    def create

        # render json: {cast: params[:cast_id]}
        movie = Movie.new(movie_params)
        #convert title to slug
        movie.slug = movie_params[:title].parameterize
        #add casts to movie
        if params[:cast_id]
            params[:cast_id].each do |cast|
                existing_cast = Cast.find_by_id(cast)
                movie.casts << existing_cast if existing_cast.present?
            end
        end
        
        if movie.save
            render json: movie
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
        #convert title to slug
        movie.slug = params[:title].parameterize

        #remove existing casts
        movie.casts.clear
        #add new set of casts to movie
        if params[:cast_id]
            params[:cast_id].each do |cast|
                existing_cast = Cast.find_by_id(cast)
                movie.casts << existing_cast if existing_cast.present?
            end
        end

        if movie.update(movie_params)
            render json: movie
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
        
        render json: movie
    end
    
    private
    
        def movie_params
            params.permit(:id, :title, :release_year, :thumbnail_url, :slug, :image)
        end
end
