class FavoritesFacade
    attr_reader :params, :favorite_params, :get_user_from_token

    def initialize(params = nil, favorite_params = nil, get_user_from_token = nil)
        @params = params
        @favorite_params = favorite_params
        @get_user_from_token = get_user_from_token
    end
    
    def add_remove_favorite
        user_id = params[:user_id]
        movie_id = params[:movie_id]

        favorite = Favorite.where(user_id: user_id, movie_id: movie_id).first

        if favorite
            remove_favorite(favorite)
        else
            add_favorite()
        end
    end

    private
        def remove_favorite(favorite)
            favorite.destroy
    
            return :json => favorite.to_json
        end

        def add_favorite()
            favorite = Favorite.new(favorite_params)

            if favorite.save
                return :json => favorite.to_json
            else
                return :json => {
                    status: 'ERROR',
                    message: 'Data not saved',
                    data: favorite.errors
                }, status: :unprocessable_entity
            end
        end

        def get_user_from_token
            jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], ENV['DEVISE_JWT_SECRET_KEY']).first
            user_id = jwt_payload['sub']
            user = User.find(user_id.to_s)
        end

end