module Api
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_user!

      skip_forgery_protection

      rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

      private

      def render_not_found(exception)
        render json: json_error_response(
          status: :not_found,
          title: "Not found",
          detail: exception.message
        ), status: :not_found
      end

      def render_record_invalid(exception)
        render json: json_validation_error_response(exception.record), status: :unprocessable_entity
      end
    end
  end
end
