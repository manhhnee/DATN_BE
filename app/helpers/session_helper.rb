# frozen_string_literal: true
module SessionHelper
  def current_user
    return @current_user if defined?(@current_user)

    token = request.headers["Authorization"]&.split(" ")&.last
    if token
      decoded_token = JWT.decode(token, Rails.application.secret_key_base)
      user_id = decoded_token[0]["id"]
      @current_user = User.find_by(id: user_id)
    end
    @current_user
  rescue JWT::DecodeError
    nil
  end
end
