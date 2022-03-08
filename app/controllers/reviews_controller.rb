class ReviewsController < ApplicationController
    def index
        reviews = Review.order('created_at DESC');

        options = {
            :include => [ :movie, :user]
        }

        render :json => reviews.to_json(options)
    end
    
    def show
        review = Review.find_by_id(params[:id])
        options = {
            :include => [ :movie, :user]
        }
        render :json => review.to_json(options)
    end

    def create
        review = Review.new(review_params)

        if review.save
            render json: review.to_json, status: :created
        else
            render json: {
                status: 'ERROR',
                message: 'Review not saved',
                data: review.errors
            }, status: :unprocessable_entity
        end
    end

    def update
        review = Review.find_by_id(params[:id])

        if review.update(review_params)
            render json: review.to_json
        else
            render json: {
                status: 'ERROR',
                message: 'Review not saved',
                data: review.errors
            }, status: :unprocessable_entity
        end
    end

    def destroy
        review = Review.find_by_id(params[:id])
        review.destroy

        render json: review.to_json
    end

    private
        def review_params
            params.permit(:content, :rating, :user_id, :movie_id)
        end
end
