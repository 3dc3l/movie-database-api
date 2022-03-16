class CastsFacade
    attr_reader :params, :cast_params

    def initialize(params = nil, cast_params = nil)
        @params = params
        @cast_params = cast_params
    end

    def all_casts
        casts = Cast.order('created_at DESC');

        return :json => casts.to_json
    end

    def show
        cast = Cast.find_by_id(params[:id])

        return :json => cast.to_json(:methods => [:get_image_url])
    end

    def create
        cast = Cast.new(cast_params)

        if cast.save
            return :json => cast.to_json
        else
            return :json => {
                status: 'ERROR',
                message: 'Cast not saved',
                data: cast.errors
            }, status: :unprocessable_entity
        end
    end

    def update
        cast = Cast.find_by_id(params[:id])
    
        if cast.update(cast_params)
            return :json => cast.to_json
        else
            return :json => {
                status: 'ERROR',
                message: 'Cast not updated',
                data: cast.errors
            }, status: :unprocessable_entity
        end
    end
end 