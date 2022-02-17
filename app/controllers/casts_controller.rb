class CastsController < ApplicationController
    def index
        casts = Cast.order('created_at DESC');
    
        render json: {
            status: 'SUCCESS',
            message: 'Loaded casts',
            data: casts
        }, status: :ok
    end
    
    def show
        cast = Cast.find(params[:id])
    
        render json: {
            status: 'SUCCESS',
            message: 'Loaded cast',
            data: cast
        }, status: :ok
    end
    
    def create
        cast = Cast.new(cast_params)
    
        if cast.save
            render json: {
                status: 'SUCCESS',
                message: 'Saved cast',
                data: cast
            }, status: :ok
        else
            render json: {
                status: 'ERROR',
                message: 'Cast not saved',
                data: cast.errors
            }, status: :unprocessable_entity
        end
    end
    
    def update
        cast = Cast.find(params[:id])
    
        if cast.update(cast_params)
            render json: {
                status: 'SUCCESS',
                message: 'Updated cast',
                data: cast
            }, status: :ok
        else
            render json: {
                status: 'ERROR',
                message: 'Cast not updated',
                data: cast.errors
            }, status: :unprocessable_entity
        end
    end
    
    def destroy
        cast = Cast.find(params[:id])

        cast.destroy
        render json: {
            status: 'SUCCESS',
            message: 'Deleted cast',
        }, status: :ok
    end
    
    private
    
        def cast_params
            params.permit(:first_name, :middle_name, :last_name, :suffix, :stage_name)
        end
end
