class MoviesController < ApplicationController

    def index
        movies = Movie.order('created_at DESC');
        render json: movies
    end

    def show
        movie = Movie.where(slug: params[:id]).first!
        render json: movie
    end
    
    def create
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

        #add genre
        if params[:genre_id]
            params[:genre_id].each do |genre|
                existing_genre = Genre.find_by_id(genre)
                movie.genres << existing_genre if existing_genre.present?
            end
        end
        
        if movie.save
            render json: movie, status: :created
        else
            render json: {
                status: 'ERROR',
                message: 'Movie not saved',
                data: movie.errors
            }, status: :unprocessable_entity
        end
    end
    
    def update
        movie = Movie.find_by_id(params[:id])
        #convert title to slug
        movie.slug = params[:title].parameterize

        #remove existing casts and create new set
        movie.casts.clear
        if params[:cast_id]
            params[:cast_id].each do |cast|
                existing_cast = Cast.find_by_id(cast)
                movie.casts << existing_cast if existing_cast.present?
            end
        end

        #remove existing genre and create new set
         if params[:genre_id]
            params[:genre_id].each do |genre|
                existing_genre = Genre.find_by_id(genre)
                movie.genres << existing_genre if existing_genre.present?
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
        movie = Movie.find_by_id(params[:id])
        movie.destroy
        
        render json: movie
    end
    
    private
        def movie_params
            params.permit(:id, :title, :release_year, :thumbnail_url, :slug, :image, :cast_id, :genre_id)
        end
end
