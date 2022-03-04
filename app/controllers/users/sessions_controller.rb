class Users::SessionsController < Devise::SessionsController
    respond_to :json

    def create
        super { @token = current_token }
    end

    def admin_login
        user_email = params[:user][:email]
        user = User.where(email: user_email).first

        if user && user.is_admin == 1
            
        else
            render json: {
                data:  'not'
            }
        end
    end

    def show
    end

    private
        def current_token
            request.env['warden-jwt_auth.token']
        end

    private
        def respond_with(resource, _opts = {})
            render json: { message: 'Logged in', token: @token }, status: :ok
        end

        def respond_to_on_destroy
            current_user ? log_out_success : log_out_failure
        end
        
        def log_out_success
            render json: { message: "Logged out." }, status: :ok
        end
        
        def log_out_failure
            render json: { message: "Logged out failure."}, status: :unauthorized
        end
end
