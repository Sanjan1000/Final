module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_with_token!

      def index
        @posts = @current_user.posts
        render json: @posts
      end

      private

      def authenticate_with_token!
        authenticate_or_request_with_http_token do |token, options|
          @current_user = User.find_by(api_token: token)
          render json: { error: 'Unauthorized' }, status: 401 unless @current_user
        end
      end
    end
  end
end

