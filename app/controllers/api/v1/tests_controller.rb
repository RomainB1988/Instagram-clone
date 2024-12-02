module Api
  module V1
    class TestsController < ApplicationController
      def ping
        render json: { message: "Pong!" }, status: :ok
      end
    end
  end
end
