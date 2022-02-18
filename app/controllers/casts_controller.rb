class CastsController < ApplicationController
    def index
        casts = Cast.order('created_at DESC');
        render json: casts
    end
    
    def show
        cast = Cast.find_by_id(params[:id])
        render json: cast
    end
    
    def create
        cast = Cast.new(cast_params)

        if cast.save
            render json: cast
        else
            render json: {
                status: 'ERROR',
                message: 'Cast not saved',
                data: cast.errors
            }, status: :unprocessable_entity
        end
    end
    
    def update
        cast = Cast.find_by_id(params[:id])
    
        if cast.update(cast_params)
            render json: cast
        else
            render json: {
                status: 'ERROR',
                message: 'Cast not updated',
                data: cast.errors
            }, status: :unprocessable_entity
        end
    end
    
    def destroy
        cast = Cast.find_by_id(params[:id])
        cast.destroy

        render json: cast
    end

    private
        def cast_params
            params.permit(:first_name, :middle_name, :last_name, :suffix, :stage_name, :image)
        end
end
