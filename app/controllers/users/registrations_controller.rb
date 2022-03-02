class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json

    def create 
        build_resource(sign_up_params)

        resource.save
        render_resource(resource)
    end
    
    private
        def respond_with(resource, _opts = {})
            resource.persisted? ? register_success : register_failed
        end

        def register_success
            render json: { user: @user }, status: :ok
        end

        def register_failed
            render json: { message: "Email exists. Please use other email." }
        end

        def sign_up_params
            params.require(:user).permit(:email, :password, :password_confirmation, :is_admin)
        end
end