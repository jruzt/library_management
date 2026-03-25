module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json

      skip_forgery_protection

      private

      def respond_with(resource, _options = {})
        if resource.persisted?
          sign_in(resource_name, resource)
          render json: json_response(resource: resource,
                                     serializer: UserSerializer),
                 status: :created
        else
          render json: json_validation_error_response(resource), status: :unprocessable_entity
        end
      end

      def sign_up_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      end
    end
  end
end
