class GenresController < ApplicationController
    def index
        genres = Genre.order('created_at DESC');
        render :json => genres.to_json(movies_with_users)
    end

    def show
        genre = Genre.where(slug: params[:id]).first!
        render :json => genre.to_json(movies_with_users)
    end

    def create
        genre = Genre.new(genre_params)

        if genre.save
            render json: genre.to_json, status: :created
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
            render json: genre.to_json
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

        render json: genre.to_json
    end

    private
        def genre_params
            params.permit(:title, :slug)
        end

        def movies_with_users
            options = {
                :include => { 
                    :movies => { 
                        :include => :users,
                        :methods => :get_image_url
                    } 
                }
            }
        end
end
