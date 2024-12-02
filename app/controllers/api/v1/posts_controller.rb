module Api
  module V1
    class PostsController < ApplicationController
      # Protéger certaines actions pour les utilisateurs authentifiés
      before_action :authenticate_user!, only: [:create, :like]

      def like
        post = Post.find(params[:id])
        post.increment!(:likes) # Incrémente les likes de 1
        render json: post, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Publication non trouvée" }, status: :not_found
      end

      def index
        posts = Post.all.order(created_at: :desc)
        render json: posts
      end

      def show
        post = Post.find(params[:id])
        render json: post
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Publication non trouvée" }, status: :not_found
      end

      def create
        # Associe la publication à l'utilisateur actuellement connecté
        post = current_user.posts.new(post_params)
        if post.save
          render json: post, status: :created
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def post_params
        params.require(:post).permit(:title, :description, :image, :likes)
      end
    end
  end
end
