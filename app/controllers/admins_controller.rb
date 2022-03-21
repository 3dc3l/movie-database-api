class AdminsController < ApplicationController 
    # before_action :authenticate_admin!

    def all_users
        users = User.where(is_admin: 0 ).order('created_at DESC')

        render :json => users.to_json
    end

    def show
        admin = get_admin_from_token
        
        render json: {
            message: "If you see this, you're in!",
            admin: admin
        }
    end

    def destroy_user
        user = User.find_by_id(params[:id])
        user.destroy
        
        render json: user.to_json
    end

    private
        def get_admin_from_token
            #server
            # jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], "d52ef6ba1c804a5cfcbb00c3ad17103339209e8d64f46e4d98e173b0c2b4c3ace718dd7a31e43c6fa239592d29d10c7b5fdcf1f354eead1709285638e324d85c").first
            #local
            jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], "b40fd77db45d6a45348d0c0de0f6ab8ebf16aafe3207d952fbad14e71ed672e1d50a6a6c58ce8de5d04392b17dc1a9251850e602b0cccfb176257f904df8b1bf").first
            admin_id = jwt_payload['sub']
            admin = Admin.find(admin_id.to_s)
        end
end