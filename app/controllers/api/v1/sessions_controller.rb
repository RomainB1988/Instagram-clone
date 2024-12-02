module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json

      private

      def respond_with(resource, _opts = {})
        if resource.persisted?
          render json: { message: 'Connexion réussie', user: resource }, status: :ok
        else
          render json: { error: 'Erreur lors de la connexion' }, status: :unauthorized
        end
      end

      def respond_to_on_destroy
        if current_user
          render json: { message: 'Déconnexion réussie' }, status: :ok
        else
          render json: { error: 'Non autorisé' }, status: :unauthorized
        end
      end
    end
  end
end
