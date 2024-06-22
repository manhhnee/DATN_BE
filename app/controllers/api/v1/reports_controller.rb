# app/controllers/api/v1/reports_controller.rb

module Api
  module V1
    class ReportsController < ApplicationController
      before_action :load_reports, only: %i[approve reject]
      before_action :authorize_staff, only: %i[create index]
      before_action :authorize_admin, only: %i[approve reject]

      def index
        @user_reports = current_user.reports
        render json: @user_reports, status: :ok
      end

      def create
        @report = current_user.reports.build(report_params)
        if @report.save
          render json: @report, status: :created
        else
          render json: @report.errors, status: :unprocessable_entity
        end
      end

      def pending_reports
        @pending_reports = Report.where(approved: false)
        render json: @pending_reports.as_json(
          include: {
            user: {
              only: %i[first_name last_name email],
              methods: [:avatar_url]
            }
          }
        ), status: :ok
      end

      def approve
        if @report.approved?
          render json: { error: "Report has already been approved" }, status: :unprocessable_entity
        else
          create_attendance_from_report(@report)
        end
      end

      def reject
        if @report.approved?
          render json: { error: "Cannot reject an already approved report" }, status: :unprocessable_entity
        else
          @report.destroy
          render json: { message: "Report rejected successfully" }, status: :ok
        end
      end

      private

      def report_params
        params.require(:report).permit(:date, :attendance_type_id, :time_check, :reason)
      end

      def create_attendance_from_report(report)
        attendance_params = {
          user_id: report.user_id,
          date: report.date,
          attendance_type_id: report.attendance_type_id,
          time_check: report.time_check
        }
        @attendance = Attendance.new(attendance_params)
        if @attendance.save
          @report.update(approved: true)
          render json: @attendance, status: :created
        else
          render json: @attendance.errors, status: :unprocessable_entity
        end
      end

      def load_reports
        @report = Report.find_by(id: params[:id])
        return if @report

        render json: { error: "Report not found" }, status: :not_found unless @report.present?
      end

      def authorize_staff
        render json: { error: "Unauthorized" }, status: :unauthorized unless current_user.id == params[:user_id].to_i
      end

      def authorize_admin
        render json: { error: "Unauthorized" }, status: :unauthorized unless current_user.admin?
      end
    end
  end
end
