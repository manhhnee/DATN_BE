# frozen_string_literal: true
module Api
  module V1
    class AttendanceTypesController < ApplicationController
      before_action :set_attendance_type, only: %i[show update destroy]
      before_action :authorize_admin

      # GET /api/v1/attendance_types
      def index
        attendance_types = AttendanceType.all
        render json: attendance_types, status: :ok
      end

      # GET /api/v1/attendance_types/:id
      def show
        render json: @attendance_type, status: :ok
      end

      # POST /api/v1/attendance_types
      def create
        attendance_type = AttendanceType.new(attendance_type_params)

        if attendance_type.save
          render json: attendance_type, status: :created
        else
          render json: { error: attendance_type.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/attendance_types/:id
      def update
        if @attendance_type.update(attendance_type_params)
          render json: {attendance_type: @attendance_type, message: "Attendance type updated successfully"}, status: :ok
        else
          render json: { error: @attendance_type.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/attendance_types/:id
      def destroy
        begin
          @attendance_type.destroy
          render json: { message: "Attendance type deleted successfully" }, status: :ok
        rescue => e
          render json: { error: "Failed to delete Attendance type: #{e.message}" }, status: :internal_server_error
        end
      end

      private

      def attendance_type_params
        params.require(:attendance_type).permit(:type_name)
      end

      def set_attendance_type
        @attendance_type = AttendanceType.find_by(id: params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Attendance type not found" }, status: :not_found
      end
    end
  end
end
