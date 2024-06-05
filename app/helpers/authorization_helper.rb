# frozen_string_literal: true
module AuthorizationHelper
  def authorize_admin
    token = request.headers["Authorization"]&.split(" ")&.last
    if token
      decoded_token = JWT.decode(token, Rails.application.secret_key_base)
      user_id = decoded_token[0]["id"]
      user = User.find_by(id: user_id)
      render json: { error: "Unauthorized" }, status: :unauthorized unless user&.admin?
    else
      render json: { error: "Token missing" }, status: :unauthorized
    end
  rescue JWT::DecodeError
    render json: { error: "Invalid token" }, status: :unauthorized
  end
end
