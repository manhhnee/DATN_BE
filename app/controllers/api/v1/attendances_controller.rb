# frozen_string_literal: true
module Api
  module V1
    class AttendancesController < ApplicationController
      before_action :set_attendance, only: %i[show update destroy]
      before_action :authorize_admin, except: %i[create user_attendances create_to_recognize]
      before_action :authorize_user, only: %i[create user_attendances]

      def index
        user = User.find_by(id: params[:user_id])
        attendances = user.attendances.order(date: :asc)

        serialized_attendances = attendances.map do |attendance|
          {
            id: attendance.id,
            date: attendance.date,
            attendance_type_id: attendance.attendance_type_id,
            time_check: attendance.time_check
          }
        end

        render json: serialized_attendances, status: :ok
      end

      def show
        render json: @attendance
      end

      def create
        current_time = Time.current.in_time_zone(Time.zone)
        check_in_time = Time.zone.parse(attendance_params[:time_check])
        limit_time = current_time.change(hour: 12, min: 0, sec: 0)
        if check_in_time >= limit_time
          render json: { error: "Cannot check after 19:00" }, status: :unprocessable_entity
        else
          @attendance = current_user.attendances.build(attendance_params)
          if @attendance.save
            render json: @attendance, status: :created
          else
            render json: @attendance.errors, status: :unprocessable_entity
          end
        end
      end

      def create_to_recognize
        user = User.find_by(id: params[:user_id])
        @attendance = user.attendances.build(attendance_params)
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
          regular_hours, overtime_hours = calculate_work_hours(check_in, check_out)
          time_worked = regular_hours + overtime_hours
          missing_time = if time_worked < 8.0
                           (8.0 - time_worked).round(2)
                         else
                           0
                         end
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
        time_in = time_in.in_time_zone(Time.zone)
        time_out = time_out.in_time_zone(Time.zone)

        if time_in.hour > 10
          total_regular_hours = 0
          overtime_hours = 0
        else
          time_in = Time.zone.local(time_in.year, time_in.month, time_in.day, 1, 0, 0) if time_in.hour < 1

          regular_work_end_time = Time.zone.local(time_out.year, time_out.month, time_out.day, 10, 0, 0)
          limited_time_out = time_out.hour < 10 ? time_out : [time_out, regular_work_end_time].min

          regular_hours_worked = limited_time_out.hour - time_in.hour
          regular_hours_worked -= 1 if time_in.hour < 6 && limited_time_out.hour > 5
          regular_minutes_worked = limited_time_out.min - time_in.min
          total_regular_hours = regular_hours_worked + (regular_minutes_worked / 60.0)

          overtime_hours = if time_out > regular_work_end_time
                             ((time_out - regular_work_end_time) / 3600.0).round(2)
                           else
                             0
                           end
        end

        [total_regular_hours.round(2), overtime_hours.round(2)]
      end
    end
  end
end
