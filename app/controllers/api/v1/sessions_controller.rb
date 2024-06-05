# frozen_string_literal: true
module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.authenticate(params[:email], params[:password])
        if user
          remember = params[:remember] == "true"
          token = user.generate_jwt(remember)
          cookies.signed[:jwt] = {
            value: token,
            httponly: true,
            secure: true,
            sameSite: "None",
            expires: remember ? 1.week.from_now : nil
          }
          render json: { token:, message: "Logged in successfully", user_id: user.id, role: user.role }
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

      def destroy
        cookies.delete(:jwt)
        render json: { message: "Logged out successfully" }, status: :ok
      end
    end
  end
end
