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
            favorite = Favorite.new(@params)

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
            #server
            jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], "d52ef6ba1c804a5cfcbb00c3ad17103339209e8d64f46e4d98e173b0c2b4c3ace718dd7a31e43c6fa239592d29d10c7b5fdcf1f354eead1709285638e324d85c").first
            #local
            # jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], "b40fd77db45d6a45348d0c0de0f6ab8ebf16aafe3207d952fbad14e71ed672e1d50a6a6c58ce8de5d04392b17dc1a9251850e602b0cccfb176257f904df8b1bf").first
            user_id = jwt_payload['sub']
            user = User.find(user_id.to_s)
        end

end
