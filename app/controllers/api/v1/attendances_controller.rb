# frozen_string_literal: true
module Api
  module V1
    class AttendancesController < ApplicationController
      before_action :set_attendance, only: %i[show update destroy]
      before_action :authorize_admin, except: %i[create]
      before_action :authorize_user, only: [:create]

      def index
        @attendances = Attendance.all
        render json: {data: @attendances}
      end

      def show
        render json: @attendance
      end

      def create
        @attendance = current_user.attendances.build(attendance_params)
        if @attendance.save
          render json: @attendance, status: :created
        else
          render json: @attendance.errors, status: :unprocessable_entity
        end
      end

      def update
        if @attendance.update(attendance_params)
          render json: @attendance
        else
          render json: @attendance.errors, status: :unprocessable_entity
        end
      end

      def destroy
        begin
          @attendance.destroy
          render json: { message: "Attendance deleted successfully" }, status: :ok
        rescue => e
          render json: { error: "Failed to delete Attendance: #{e.message}" }, status: :internal_server_error
        end
      end

      private

      def set_attendance
        @attendance = Attendance.find_by(id: params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Attendance not found" }, status: :not_found
      end

      def authorize_user
        render json: { error: "Unauthorized" }, status: :unauthorized unless current_user.id == params[:user_id].to_i
      end

      def attendance_params
        params.require(:attendance).permit(:date, :attendance_type_id, :time_check)
      end
    end
  end
end
