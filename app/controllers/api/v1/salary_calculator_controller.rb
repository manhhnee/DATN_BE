# frozen_string_literal: true

module Api
  module V1
    class SalaryCalculatorController < ApplicationController
      def calculate_salary
        user_id = params[:user_id]
        monthly_salaries = {}

        12.times do |i|
          date = Date.today.at_beginning_of_month - i.months
          start_date = date.at_beginning_of_month
          end_date = date.at_end_of_month

          attendances = Attendance.where(user_id:, date: start_date..end_date).order(:date, :time_check)

          total_salary = 0
          attendances.group_by(&:date).each do |_, daily_attendances|
            next unless daily_attendances.present?

            time_in = daily_attendances.first.time_check
            time_out = daily_attendances.last.time_check

            work_hours = calculate_work_hours(time_in, time_out)
            total_salary += calculate_monthly_salary(work_hours)
          end

          monthly_salaries[date.strftime("%B")] = total_salary
        end

        sorted_monthly_salaries = monthly_salaries.sort_by { |month, _salary| Date::MONTHNAMES.index(month) }

        render json: sorted_monthly_salaries.to_h
      end

      private

      def calculate_work_hours(time_in, time_out)
        time_in = Time.new(time_in.year, time_in.month, time_in.day, 8, 0, 0) if time_in.hour < 8

        work_end_time = Time.new(time_out.year, time_out.month, time_out.day, 17, 0, 0)
        limited_time_out = time_out.hour < 17 ? time_out : [time_out, work_end_time].min

        hours_worked = limited_time_out.hour - time_in.hour
        hours_worked -= 1 if time_in.hour < 13 && limited_time_out.hour > 12
        minutes_worked = limited_time_out.min - time_in.min
        hours_worked + (minutes_worked / 60.0)
      end

      def calculate_monthly_salary(work_hours)
        if work_hours >= 4
          work_hours * 300_000
        else
          work_hours * 300_000 * 0.8
        end
      end
    end
  end
end
