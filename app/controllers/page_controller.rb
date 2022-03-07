class PageController < ApplicationController
    #will use on other pages

    def movie_list 
        user = User.where(id: params[:id]).first()
        movies = Movie.order('created_at DESC');

        if user.present?
            user.movies.each do |user_movie|
                movies.each do |default_movie|
                    if user_movie.id == default_movie.id
                        default_movie.is_favorite = true
                    else
                        default_movie.is_favorite = false
                    end
                end
            end
        end

        render json: movies.to_json
    end

    def movie_by_slug
        movie = Movie.where(slug: params[:id]).first

        options = {
            :include => [ 
                :users, 
                :genres, 
                :casts => {
                    :methods => :get_image_url
                }
            ],
            :methods => :get_image_url
        }
        
        render :json => movie.to_json(options)
    end

    def movie_reviews
        movie_slug = params[:movie_slug]
        movie = Movie.where(slug: movie_slug).first!

        render :json => movie.reviews.to_json(:include => :user)
    end
    
    def quick_search
        movies = Movie.where("title LIKE ?", "%#{params[:query]}%")

        render :json => movies.to_json(:include => :genres)
    end

    def genres_and_casts
        genres = Genre.order('created_at DESC');
        casts = Cast.order('created_at DESC');
        
        genres.each do |item|
            item.label = item.title
        end

        casts.each do |item|
            item.label = item.first_name + " " + item.middle_name + " " + item.last_name
        end
        
        render json: { 
            genres: genres.as_json(methods: [:label]), 
            casts: casts.as_json(methods: [:label]), 
        } 
    end

end