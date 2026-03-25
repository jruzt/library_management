module Api
  module V1
    class CurrentUserController < BaseController
      def show
        render json: json_response(resource: current_user,
                                   serializer: UserSerializer)
      end
    end
  end
end
