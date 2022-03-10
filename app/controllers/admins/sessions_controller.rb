class Admins::SessionsController < Devise::SessionsController
  respond_to :json

    def create
        super { @token = current_token }
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
            current_admin ? log_out_success : log_out_failure
        end
        
        def log_out_success
            render json: { message: "Logged out." }, status: :ok
        end
        
        def log_out_failure
            render json: { message: "Logged out failure."}, status: :unauthorized
        end
end