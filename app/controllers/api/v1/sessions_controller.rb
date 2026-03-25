module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json

      skip_forgery_protection

      def destroy
        sign_out(resource_name)
        render json: { meta: { message: "Logged out successfully" } }, status: :ok
      end

      private

      def respond_with(resource, _options = {})
        render json: json_response(
          resource: resource,
          serializer: UserSerializer
        ), status: :ok
      end
    end
  end
end
