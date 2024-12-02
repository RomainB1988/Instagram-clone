module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json

      def create
        Rails.logger.debug "Params reçus : #{params.inspect}"

        build_resource(sign_up_params)
        resource.save
        if resource.persisted?
          render json: { message: 'Inscription réussie', user: resource }, status: :created
        else
          render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end


      private

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end
