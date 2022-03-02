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

        render json: movies
    end

end