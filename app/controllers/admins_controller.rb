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
            jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], ENV['DEVISE_JWT_SECRET_KEY']).first
            admin_id = jwt_payload['sub']
            admin = Admin.find(admin_id.to_s)
        end
end