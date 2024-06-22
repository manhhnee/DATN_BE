# frozen_string_literal: true

module Api
  module V1
    class SalariesController < ApplicationController
      def index
        user_id = params[:user_id]
        salaries = Salary.where(user_id:).order(date: :desc).limit(12)

        render json: salaries.map { |salary| { month: salary.date.strftime("%B"), total_salary: salary.total_salary } }
      end

      def create
        user_id = salary_params[:user_id]
        user = User.find_by(id: user_id)

        return render json: { error: "User not found" }, status: :not_found unless user

        basic_salary = user.basic_salary

        existing_salaries = Salary.where(user_id:)
        existing_salaries.destroy_all if existing_salaries.present?

        12.times do |i|
          date = Date.today.at_beginning_of_month - i.months
          start_date = date.at_beginning_of_month
          end_date = date.at_end_of_month

          attendances = Attendance.where(user_id:, date: start_date..end_date).order(:date, :time_check)

          total_salary = 0
          attendances.group_by(&:date).each_value do |daily_attendances|
            next unless daily_attendances.present?

            time_in = daily_attendances.first.time_check
            time_out = daily_attendances.last.time_check

            regular_hours, overtime_hours = calculate_work_hours(time_in, time_out)
            total_salary += calculate_monthly_salary(regular_hours, overtime_hours, basic_salary, daily_attendances.first.date)
          end

          Salary.create!(user_id:, date:, total_salary:)
        end

        render json: { message: "Salaries calculated and saved successfully" }, status: :created
      end

      def total_work_hours_all_users
        start_date = Date.today.at_beginning_of_year
        end_date = Date.today.at_end_of_year

        attendances_by_date = Attendance.where(date: start_date..end_date).group_by(&:date)

        total_work_hours_by_user = Hash.new(0)

        attendances_by_date.each_value do |attendances|
          attendances_by_user = attendances.group_by(&:user_id)

          attendances_by_user.each do |user_id, user_attendances|
            time_check_in = user_attendances.min_by(&:time_check).time_check
            time_check_out = user_attendances.max_by(&:time_check).time_check

            regular_hours, overtime_hours = calculate_work_hours(time_check_in, time_check_out)
            total_work_hours_by_user[user_id] += regular_hours + overtime_hours
          end
        end

        top_six_users = total_work_hours_by_user.sort_by { |_user_id, total_hours| total_hours }.reverse.first(6)

        user_names = User.where(id: total_work_hours_by_user.keys).pluck(:id, :first_name, :last_name)
        top_six_users_with_names = top_six_users.map do |user_id, total_hours|
          user_info = user_names.find { |info| info[0] == user_id }
          full_name = user_info ? "#{user_info[1]} #{user_info[2]}" : "Unknown User"
          [full_name, total_hours.round(2)]
        end

        render json: { total_work_hours_by_user: top_six_users_with_names.to_h }
      end

      private

      def salary_params
        params.require(:salary).permit(:user_id)
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

      def calculate_monthly_salary(regular_hours, overtime_hours, basic_salary, date)
        multiplier = if is_holiday?(date)
                       3.0
                     elsif is_weekend?(date)
                       2.0
                     elsif regular_hours < 8.0
                       0.8
                     else
                       0.0
                     end

        regular_salary = regular_hours * basic_salary * multiplier
        overtime_salary = overtime_hours * basic_salary * 1.5

        regular_salary + overtime_salary
      end

      def is_weekend?(date)
        date.saturday? || date.sunday?
      end

      def is_holiday?(date)
        Holiday.exists?(holiday_date: date)
      end
    end
  end
end
