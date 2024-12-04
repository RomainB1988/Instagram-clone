class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  before_action :ensure_json_request

  def current_user
    token = request.headers['Authorization']&.split(' ')&.last
    @current_user ||= User.find_by(authentication_token: token)
  end
  def ensure_json_request
    return if request.format == :json

    render json: { error: 'Format non supporté' }, status: :not_acceptable
  end
end
