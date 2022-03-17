class CastsController < ApplicationController

    def index
        casts = CastsFacade.new
        render casts.all_casts
    end
    
    def show
       cast = CastsFacade.new(params)
       render cast.show
    end
    
    def create
        cast = CastsFacade.new(params, cast_params)
        render cast.create
    end
    
    def update
        cast = CastsFacade.new(params, cast_params)
        render cast.update
    end
    
    def destroy
        cast = Cast.find_by_id(params[:id])
        cast.destroy

        render json: cast.to_json
    end

    private
        def cast_params
            params.permit(:first_name, :middle_name, :last_name, :suffix, :stage_name, :image)
        end
end
