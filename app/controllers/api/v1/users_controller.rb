# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :load_user, only: %i[show update_user update_admin destroy]
      before_action :authorize_admin, only: %i[update_admin create destroy index]
      before_action :authorize_user, only: %i[show update_user]

      def index
        @users = User.order("created_at DESC")
        render json: {
          status: true,
          data: @users.map { |user| user.as_json(only: %i[id first_name last_name phone_number date_of_birth email role department_id basic_salary], methods: [:avatar_url]) }
        }, status: :ok
      end

      def show
        user_data = @user.as_json(only: %i[id first_name last_name phone_number date_of_birth email role department_id basic_salary])
        user_data[:avatar_url] = @user.avatar_url if @user.avatar.attached?
        render json: { status: true, data: user_data }, status: :ok
      end

      def create
        if User.exists?(email: user_params[:email])
          render json: { error: "Email already exists" }, status: :unprocessable_entity
        else
          @user = User.new(user_params)
          @user.avatar.attach(params[:avatar]) if params[:avatar].present?

          if @user.save
            user_data = @user.as_json(only: %i[id first_name last_name phone_number date_of_birth email role department_id basic_salary])
            user_data[:avatar_url] = @user.avatar_url if @user.avatar.attached?
            render json: { user: user_data, message: "User created successfully" }, status: :created
          else
            render json: { error: @user.errors.full_messages.join(", ") }, status: :unprocessable_entity
          end
        end
      end

      def update_user
        if @user.update(user_update_params)
          @user.avatar.attach(params[:avatar]) if params[:avatar]
          user_data = @user.as_json(only: %i[id first_name last_name phone_number date_of_birth email role department_id])
          user_data[:avatar_url] = @user.avatar_url if @user.avatar.attached?
          render json: { user: user_data, message: "User updated successfully" }, status: :ok
        else
          render json: { error: @user.errors.full_messages.join(", ") }, status: :unprocessable_entity
        end
      end

      def update_admin
        if @user.update(user_params)
          @user.avatar.attach(params[:avatar]) if params[:avatar]
          user_data = @user.as_json(only: %i[id first_name last_name phone_number date_of_birth email role department_id])
          user_data[:avatar_url] = @user.avatar_url if @user.avatar.attached?
          render json: { user: user_data, message: "Admin updated successfully" }, status: :ok
        else
          render json: { error: @user.errors.full_messages.join(", ") }, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
        render json: { message: "User deleted successfully" }, status: :ok
      rescue StandardError => e
        render json: { error: "Failed to delete user: #{e.message}" }, status: :internal_server_error
      end

      private

      def user_params
        params.permit(:first_name, :last_name, :phone_number, :date_of_birth, :email, :password, :department_id, :basic_salary)
      end

      def user_update_params
        params.permit(:first_name, :last_name, :phone_number, :date_of_birth, :password)
      end

      def load_user
        @user = User.find_by(id: params[:id])
        return if @user

        render json: { status: 404, message: "User not found" }, status: :not_found
      end

      def authorize_user
        render json: { error: "Unauthorized" }, status: :unauthorized unless current_user.id == params[:id].to_i
      end

      def authorize_admin
        render json: { error: "Unauthorized" }, status: :unauthorized unless current_user.admin?
      end
    end
  end
end
