# frozen_string_literal: true
module Api
  module V1
    class AttendancesController < ApplicationController
      before_action :set_attendance, only: %i[show update destroy]
      before_action :authorize_admin, except: %i[create user_attendances]
      before_action :authorize_user, only: %i[create user_attendances]

      def index
        user = User.find(params[:user_id])
        attendances_by_date = user.attendances.group_by(&:date)

        attendance_times_by_date = {}
        attendances_by_date.each do |date, attendances|
          check_in = attendances.map(&:time_check).min
          check_out = attendances.map(&:time_check).max
          attendance_times_by_date[date] = { check_in:, check_out: }
        end

        sorted_attendance_times_by_date = attendance_times_by_date.sort_by { |date, _| date }

        render json: sorted_attendance_times_by_date.to_h, status: :ok
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
        @attendance.destroy
        render json: { message: "Attendance deleted successfully" }, status: :ok
      rescue StandardError => e
        render json: { error: "Failed to delete Attendance: #{e.message}" }, status: :internal_server_error
      end

      def user_attendances
        user = User.find(params[:user_id])
        attendances_by_date = user.attendances.group_by(&:date)

        attendance_times_by_date = {}
        attendances_by_date.each do |date, attendances|
          check_in = attendances.map(&:time_check).min
          check_out = attendances.map(&:time_check).max
          time_worked = calculate_work_hours(check_in, check_out)
          missing_time = (8.0 - time_worked).round(2)
          attendance_times_by_date[date] = { check_in:, check_out:, time_worked:, missing_time: }
        end

        sorted_attendance_times_by_date = attendance_times_by_date.sort_by { |date, _| date }

        render json: sorted_attendance_times_by_date.to_h, status: :ok
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

      def calculate_work_hours(time_in, time_out)
        time_in = Time.new(time_in.year, time_in.month, time_in.day, 8, 0, 0) if time_in.hour < 8

        work_end_time = Time.new(time_out.year, time_out.month, time_out.day, 17, 0, 0)
        limited_time_out = time_out.hour < 17 ? time_out : [time_out, work_end_time].min

        hours_worked = limited_time_out.hour - time_in.hour
        hours_worked -= 1 if time_in.hour < 13 && limited_time_out.hour > 12
        minutes_worked = limited_time_out.min - time_in.min
        total_hours_worked = hours_worked + (minutes_worked / 60.0)

        total_hours_worked.round(2)
      end
    end
  end
end
