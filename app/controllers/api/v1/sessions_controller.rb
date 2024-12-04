module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json

      before_action :authenticate_user!, only: [:destroy]

      def create
        self.resource = warden.authenticate!(auth_options)
        if resource.present?
          sign_in(resource_name, resource)
          render json: {
            message: 'Connexion réussie',
            user: {
              id: resource.id,
              email: resource.email,
              authentication_token: resource.authentication_token
            }
          }, status: :ok
        else
          render json: { error: 'Erreur lors de la connexion' }, status: :unauthorized
        end
      end

      def destroy
        if current_user
          current_user.update(authentication_token: nil)
          render json: { message: 'Déconnexion réussie' }, status: :ok
        else
          render json: { error: 'Non autorisé ou déjà déconnecté' }, status: :unauthorized
        end
      end

      private

      def current_user
        token = request.headers['Authorization']&.split(' ')&.last
        @current_user ||= User.find_by(authentication_token: token)
      end
    end
  end
end
