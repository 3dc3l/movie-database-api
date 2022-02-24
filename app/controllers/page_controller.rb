class PageController < ApplicationController
    def home
        genre = Genre.all
        render json: genre
    end
end